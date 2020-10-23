import Quagga from "quagga";
$(document).ready(() => {
  const startScan = document.querySelector("#startScan");

  startScan.addEventListener("click", () => {
    Quagga.init(
      {
        inputStream: {
          name: "Live",
          type: "LiveStream",
          target: document.querySelector("#barcodeScan"), // Or '#yourElement' (optional)
        },
        decoder: {
          readers: ["code_128_reader"],
        },
      },
      function (err) {
        if (err) {
          console.log(err);
          return;
        }
        console.log("Initialization finished. Ready to start");
        Quagga.start();
      }
    );
    Quagga.onDetected(onDetect);
  });
});

function onDetect(data) {
  Quagga.stop();
  Quagga.offProcessed();
  alert(data.codeResult.code);
}
