import { Controller } from "@hotwired/stimulus";
import jsrsasign from "jsrsasign";
import CryptoJS from "crypto-js";

export default class extends Controller {
  static targets = [
    "sdkKey",
    "secretKey",
    "userName",
    "userLastname",
    "userNutritionist",
    "meetingId",
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

          if (window.ZoomMtg) {
            console.log("Now it is");
            ZoomMtg.setZoomJSLib("https://source.zoom.us/2.13.0/lib", "/av");
            ZoomMtg.preLoadWasm();
            ZoomMtg.prepareWebSDK();
            ZoomMtg.i18n.load("en-US");
            ZoomMtg.i18n.reload("en-US");
            this.initializeZoom(sdkKey, secretKey, zoomName, rol, meetingNum);
          }
        }
      }
    };

    document.addEventListener("turbo:load", initializeZoom);
  }

  disconnect() {
    location.reload();
  }

  initializeZoom(sdkKey, secretSdkKey, zoomName, rol, meetingNum) {
    const leaveUrl = "http://localhost:3000/";
    const meetingNumber = meetingNum;
    const userName = zoomName;
    const role = rol;

    const signature = this.generateSignature(
      sdkKey,
      secretSdkKey,
      meetingNumber,
      role
    );

    console.log(`the signature is ${signature}`);

    ZoomMtg.init({
      leaveUrl: leaveUrl,
      success: (success) => {
        this.joinMeeting(sdkKey, signature, meetingNumber, userName);
      },
      error: (error) => {
        console.log(error);
      },
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

  joinMeeting(sdkKey, signature, meetingNumber, userName) {
    ZoomMtg.join({
      sdkKey: sdkKey,
      signature: signature,
      meetingNumber: meetingNumber,
      passWord: "nu7ri4",
      userName: userName,
      success: (success) => {
        console.log(success);
      },
      error: (error) => {
        console.log(error);
      },
    });
  }
}
