import Quagga from "quagga";
$(document).on("turbolinks:load", function () {
  let button =
    document.querySelector(".button.scan") ||
    document.querySelector(".search_by_scan");
  let scanner = document.querySelector(".scanner");

  let closedButton = document.querySelector(".closed");

  function scanInit() {
    scanner.classList.toggle("d-none");

    Quagga.init(
      {
        inputStream: {
          name: "Live",
          type: "LiveStream",
          target: document.querySelector(".scanner"), // Or '#yourElement' (optional)
          constraints: {
            width: 800,
            height: 600,
            facingMode: "environment",
          },
        },
        locate: {
          halfSample: true,
          patchSize: "medium", // x-small, small, medium, large, x-large
        },
        area: {
          // defines rectangle of the detection/localization area
          top: "0%", // top offset
          right: "0%", // right offset
          left: "0%", // left offset
          bottom: "0%", // bottom offset
        },
        decoder: {
          readers: ["ean_reader"],
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
  }
  function onDetect(result) {
    if (button.classList[0] == "search_by_scan") {
      window.location.assign("/products/" + result.codeResult.code);
    } else {
      document.querySelector(".barcode").value = result.codeResult.code;
      scanner.classList.toggle("d-none");
      attachListener(button);
    }
    Quagga.stop();
    Quagga.offProcessed();
  }
  function cancelScan(e) {
    e.preventDefault();
    scanner.classList.toggle("d-none");
    console.log(scanner.classList);
    Quagga.stop();
    Quagga.offProcessed();
    closedButton.removeEventListener("click", cancelScan);
    closedButton.style.zIndex = "-1";

    attachListener(button);
  }
  function attachListener(seletor) {
    seletor.addEventListener("click", function onClick(e) {
      e.preventDefault();
      closedButton.addEventListener("click", cancelScan);
      closedButton.style.zIndex = "0";
      seletor.removeEventListener("click", onClick);
      scanInit();
      Quagga.onDetected(onDetect);
    });
  }
  if (button != null) {
    attachListener(button);
  }
});
