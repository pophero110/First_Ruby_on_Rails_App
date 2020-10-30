$(document).on("turbolinks:load", function () {
  let searchProduct = document.querySelector(".search_product");
  let productBarcode = document.querySelector(".product_barcode");
  if (searchProduct != null) {
    searchProduct.addEventListener("click", () => {
      window.location.assign("/products/" + productBarcode.value);
    });
  }

  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.has("error")) {
    $(".error-modal").modal();
  }
});
