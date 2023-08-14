import { Controller } from "@hotwired/stimulus";
import jsrsasign from "jsrsasign";
import CryptoJS from "crypto-js";
import axios from "axios";

export default class extends Controller {
  static targets = [
    "sdkKey",
    "secretKey",
    "userName",
    "userLastname",
    "userNutritionist",
    "meetingId",
    "professionalUsername",
  ];

  async connect() {
    const initializeZoom = async () => {
      const zoomController = document.querySelector('[data-controller="zoom"]');
      if (zoomController) {
        if (window.ZoomMtg) {
          console.log("ZoomMtg is available in the window");
        } else {
          console.log("ZoomMtg is not available in the window");
          const { ZoomMtg } = await import("@zoomus/websdk");
          const sdkKey = this.sdkKeyTarget.dataset.sdkKey;
          const secretKey = this.secretKeyTarget.dataset.secretKey;
          const userName = this.userNameTarget.dataset.userName;
          const userLastname = this.userLastnameTarget.dataset.userLastname;
          const userNutritionist =
            this.userNutritionistTarget.dataset.userNutritionist;
          const zoomName = `${userName} ${userLastname}`;
          const rol = userNutritionist == "true" ? 1 : 0;
          const meetingId = this.meetingIdTarget.dataset.meetingId;
          const meetingNum = Number(meetingId);
          const professionalUsername =
            this.professionalUsernameTarget.dataset.professionalUsername;

          if (window.ZoomMtg) {
            console.log("Now it is");
            ZoomMtg.setZoomJSLib("https://source.zoom.us/2.13.0/lib", "/av");
            ZoomMtg.preLoadWasm();
            ZoomMtg.prepareWebSDK();
            ZoomMtg.i18n.load("en-US");
            ZoomMtg.i18n.reload("en-US");
            this.initializeZoom(
              sdkKey,
              secretKey,
              zoomName,
              rol,
              meetingNum,
              professionalUsername
            );
          }
        }
      }
    };

    document.addEventListener("turbo:load", initializeZoom);
  }

  disconnect() {
    location.reload();
  }

  async getCurrentMeetingInfo() {
    return new Promise((resolve, reject) => {
      ZoomMtg.getCurrentMeetingInfo({
        success: (meetingInfo) => {
          resolve(meetingInfo);
        },
        error: (error) => {
          reject(error);
        },
      });
    });
  }

  initializeZoom(sdkKey, secretSdkKey, zoomName, rol, meetingNum, username) {
    console.log("Function initializeZoom was executed");

    const clientId = "qRu4sb4eSh2KiiRWRbH4RA";
    const clientSecret = "Ix04IDo2GHNu1vCrsYR0K2vADuNf8hBK";
    const credentials = `${clientId}:${clientSecret}`;
    const encodedCredentials = this.base64UrlEncode(credentials);

    // Obtener Token de Acceso
    axios
      .post(
        "https://zoom.us/oauth/token",
        new URLSearchParams({
          grant_type: "client_credentials",
        }),
        {
          headers: {
            Authorization: `Basic ${encodedCredentials}`,
            "Content-Type": "application/x-www-form-urlencoded",
          },
        }
      )
      .then((tokenResponse) => {
        const accessToken = tokenResponse.data.access_token;
        console.log("Access Token: " + accessToken);

        // Obtener Información de la Reunión
        const meetingId = meetingNum.toString();
        axios
          .get(`https://api.zoom.us/v2/meetings/${meetingId}`, {
            headers: {
              Authorization: `Bearer ${accessToken}`,
            },
          })
          .then((meetingInfoResponse) => {
            const meetingInfoData = meetingInfoResponse.data;
            const meetingStatus = meetingInfoData.status;
            console.log("Meeting status: " + meetingStatus);

            // Configurar leaveUrl en base al Estado de la Reunión
            let leaveUrl;
            if (rol === 0) {
              if (meetingStatus === "waiting") {
                leaveUrl = "https://www.nutrialic.com/";
              } else {
                leaveUrl = `https://www.nutrialic.com/review/new/${username}`;
              }
            } else {
              leaveUrl = "https://www.nutrialic.com/";
            }

            const meetingNumber = meetingNum;
            const userName = zoomName;
            const role = rol;

            const signature = this.generateSignature(
              sdkKey,
              secretSdkKey,
              meetingNumber,
              role
            );

            // Configurar initializeZoom
            ZoomMtg.init({
              leaveUrl: leaveUrl,
              success: async (success) => {
                this.joinMeeting(
                  sdkKey,
                  signature,
                  meetingNumber,
                  userName,
                  role
                );
              },
              error: (error) => {
                console.log(error);
              },
            });
          })
          .catch((error) => {
            console.log(error);
          });
      })
      .catch((error) => {
        console.log(error);
      });
  }

  generateSignature(sdkKey, secretSdkKey, meetingNumber, role) {
    const iat = Math.round(new Date().getTime() / 1000) - 30;
    const exp = iat + 60 * 60 * 2;

    const oHeader = {
      alg: "HS256",
      typ: "JWT",
    };

    const oPayload = {
      sdkKey: sdkKey,
      mn: meetingNumber,
      role: role,
      iat: iat,
      exp: exp,
      tokenExp: exp,
    };

    const sHeader = this.base64UrlEncode(JSON.stringify(oHeader));
    const sPayload = this.base64UrlEncode(JSON.stringify(oPayload));

    const signature = CryptoJS.HmacSHA256(
      `${sHeader}.${sPayload}`,
      secretSdkKey
    )
      .toString(CryptoJS.enc.Base64)
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=+$/, "");

    return `${sHeader}.${sPayload}.${signature}`;
  }

  base64UrlEncode(string) {
    const base64 = CryptoJS.enc.Base64.stringify(
      CryptoJS.enc.Utf8.parse(string)
    );
    return base64.replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
  }

  async joinMeeting(sdkKey, signature, meetingNumber, userName, role) {
    console.log("Function joinMeeting was executed");
    ZoomMtg.join({
      sdkKey: sdkKey,
      signature: signature,
      meetingNumber: meetingNumber,
      passWord: "nu7ri4",
      userName: userName,
      success: async (success) => {
        console.log(success);
        if (role === 0) {
          const meetingInfo = await this.getCurrentMeetingInfo();
          console.log(JSON.stringify(meetingInfo, null, 2));
          if (meetingInfo && meetingInfo.status === "waiting") {
            console.log("La reunión no ha comenzado");
            console.log("Meeting info waiting: " + meetingInfo);
          } else {
            console.log("Te has unido a la reunión exitosamente");
            console.log("Meeting info success: " + meetingInfo.status);
          }
        }
      },
      error: (error) => {
        console.log(error);
      },
    });
  }
}
