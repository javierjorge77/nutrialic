import { Controller } from "@hotwired/stimulus";
import jsrsasign from "jsrsasign";
import CryptoJS from "crypto-js";

export default class extends Controller {
  async connect() {
    document.addEventListener("DOMContentLoaded", async () => {
      if (window.ZoomMtg) {
        console.log("ZoomMtg is available in the window");
      } else {
        console.log("ZoomMtg is not available in the window");
        const { ZoomMtg } = await import("@zoomus/websdk");

        if (window.ZoomMtg) {
          console.log("Now it is");
          ZoomMtg.setZoomJSLib("https://source.zoom.us/2.13.0/lib", "/av");
          ZoomMtg.preLoadWasm();
          ZoomMtg.prepareWebSDK();
          ZoomMtg.i18n.load("en-US");
          ZoomMtg.i18n.reload("en-US");
          this.initializeZoom();
        }
      }
    });
  }

  disconnect() {
    location.reload();
  }

  initializeZoom() {
    const leaveUrl = "http://localhost:3000/";
    const sdkKey = "p2k_JOnpTs6sN6LLSyoGVQ";
    const secretSdkKey = "6VSnpg1ygTNIzjF1OJFMBAJ16SMGdp6h";
    const meetingNumber = 5503906924;
    const userName = "Daniel Carrillo";
    const role = 1;

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
      passWord: "",
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
