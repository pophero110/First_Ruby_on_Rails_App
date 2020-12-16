$(document).on("turbolinks:load", function () {
  let selectShipmentTemplate = document.querySelector(
    ".select_shipment_template"
  );

  if (selectShipmentTemplate != null) {
    selectShipmentTemplate.addEventListener("click", function (e) {
      e.defaultPrevented;
      let category_id = document.querySelector("#category_id")
        .selectedOptions[0].value;
      window.location.assign("/shipments/new" + "?category_id=" + category_id);
    });
  }
});
