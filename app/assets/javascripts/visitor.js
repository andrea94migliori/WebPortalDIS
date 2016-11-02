function CountryStateSelect(options) {

  var state_id = options['state_id'];
  var country_id = options['country_id'];
  var city_id = options['city_id'];

  var state_name = $('#' + state_id).attr('name');
  var state_class = $('#' + state_id).attr('class');

  var city_name = $('#' + city_id).attr('name');
  var city_class = $('#' + city_id).attr('class');

  return statesDropdown();

  // ====== ***** METHODS ***** ===================================================================== //
  function statesDropdown() {

    addChosenToCountry();
    addChosenToState();
    addChosenToCity();

    $("#" + country_id).click(function () {
      return findStates($(this).val());
    });

  }

  function citiesDropdown() {
     $("#" + state_id).click(function () {
      return findCities($("#" + state_id).val(),$("#" + country_id).val());
    });
  }

  function addChosenToState(){
    if (chosenIsRequired() && stateIsNotText()) {
      $('#' + state_id).chosen(options['chosen_options']);
    }
  }

  function addChosenToCity(){
    if (chosenIsRequired() && cityIsNotText()) {
      $('#' + city_id).chosen(options['chosen_options']);
    }
  }

  function stateIsNotText(){
    return !$('#' + state_id).is("[type=text]");
  }

  function cityIsNotText(){
    return !$('#' + city_id).is("[type=text]");
  }

  function addChosenToCountry(){
    if (chosenIsRequired()) {
      $('#' + country_id).chosen(options['chosen_options']);
    }
  }

  function removeChosenFromFields(){
    if (chosenIsRequired()) {
      $("#" + options['state_id'] + "_chosen").remove();
      $("#" + options['city_id'] + "_chosen").remove();
    }
  }

  function removeChosenFromCityFields(){
    if (chosenIsRequired()) {
      $("#" + options['city_id'] + "_chosen").remove();
    }
  }

  function chosenIsRequired(){
    return options.hasOwnProperty("chosen_ui") && options['chosen_ui'];
  }

  function findStates(id) {

    //Remove all Chosen from existing fields
    removeChosenFromFields();
    findCities('','')

    //Perform AJAX request to get the data; on success, build the dropdown
    $.ajax({
      url: "/find_states",
      type: 'post',
      dataType: 'json',
      cache: false,
      data: {country_id: id},
      success: function (data) { buildStatesDropdown(data) }
    });
  }

  function findCities(state_id, country_id) {

    //Remove all Chosen from existing fields
    removeChosenFromCityFields();

    //Perform AJAX request to get the data; on success, build the dropdown
    $.ajax({
      url: "/find_cities",
      type: 'post',

      dataType: 'json',
      cache: false,
      data: {
        country_id: country_id,
        state_id: state_id
      },
      success: function (data) { buildCitiesDropdown(data) }
    });
  }

  //Build the HTML for our dropdown menus
  function buildStatesDropdown(data) {
    html = "<option value=''>--seleziona regione--</option>";
    if (data.length === 0) {
      html = '<input id="' + state_id + '" name="' + state_name + '" class="' + state_class + '" type="text"  type="text" value="" >';
    } else {
      html = '<select id="' + state_id + '" name="' + state_name + '" class="' + state_class + '" >';

      for (i = 0; i < data.length; i++) {
        html += '<option value='+data[i][0]+'>' + data[i][1] + '</option>';
      }

      html += '</select>';
    }


    $('#' + state_id).replaceWith(html);

    //This has to happen AFTER we've replaced the dropdown or text
    if (data.length > 0) {
      addChosenToState();
    }

    // [142] FIXME # Is there any other way to call city method , it is adding change method in every state change 
    if(typeof city_name !== "undefined" ){
      citiesDropdown();
    };

  }

  function buildCitiesDropdown(data) {
   html = '<option value='+''+' disabled selected>--seleziona città--</option>';
    if (data.length === 0) {
      html = '<input id="' + city_id + '" name="' + city_name + '" class="' + city_class + '" type="text"  type="text" value="" >';
    } else {
      html = '<select id="' + city_id + '" name="' + city_name + '" class="' + city_class + '" >';

      for (i = 0; i < data.length; i++) {
        html += '<option>' + data[i] + '</option>';
      }

      html += '</select>';
    }

    $('#' + city_id).replaceWith(html);

    //This has to happen AFTER we've replaced the dropdown or text
    if (data.length > 0) {
      addChosenToCity();
    }

  }

}
;

$(document).on('ready page:load', function() {
  return CountryStateSelect({
    country_id: "visitor_nazioneNascita",
    state_id: "visitor_regione",
    city_id: "visitor_luogoNascita"
  });
});

$(document).on('ready page:load', function() {
  return CountryStateSelect({
    country_id: "visitor_nazioneResidenza",
    state_id: "visitor_regioneResidenza",
    city_id: "visitor_cittaResidenza"
  });
});

//altre funzioni

function visitoropen(){
    console.log("presa");
    $('#visitorModal').modal('show'); 
}

$('#visitorModal').on('click.dismiss.bs.modal', function () {
   console.log('CHIUSURA');
})

function change(){
    var elem = document.getElementById("myButton1");
    if (elem.value=="Modifica"){ 
        elem.value = "Fine";
    }
    else {
        elem.value = "Modifica";
        location.reload();
    }
}

function rel(){
    location.reload();
}

function filterGlobal () {
    $('#visitTable').DataTable().search(
        $('#global_filter').val()
    ).draw();
}

$(document).ready(function() {
    $('#visitTable').DataTable();
 
    $('input.global_filter').on( 'keyup click', function () {
        filterGlobal();
    } );
    
    $('#tutte').on('click',function(){
        $('#visitTable').DataTable().column( 5 ).search(
            ''
    ).draw();
    });
    
    $('#incorso').on('click',function(){
        $('#visitTable').DataTable().column( 5 ).search(
            'In Corso'
    ).draw();
    });
    
    $('#confermate').on('click',function(){
        $('#visitTable').DataTable().column( 5 ).search(
            'Confermata'
    ).draw();
    });
    
    $('#archiviate').on('click',function(){
        $('#visitTable').DataTable().column( 5 ).search(
            'Archiviata'
    ).draw();
    });
    
    $('#daconfermare').on('click',function(){
        $('#visitTable').DataTable().column( 5 ).search(
            'Da Confermare'
    ).draw();
    });
    
    //separatore
    
    $('#col3_filter').on('click',function(){
        $('#visitTable').DataTable().column( 3 ).search(
            ''
    ).draw();
    });
    
    $('#col3_filterPC').on('click',function(){
        $('#visitTable').DataTable().column( 3 ).search(
            '<select>'
    ).draw();
    });
    
    $('#col3_filterTablet').on('click',function(){
        $('#visitTable').DataTable().column( 3 ).search(
            'Tablet'
    ).draw();
    });
    
    $('#col3_filterPhone').on('click',function(){
        $('#visitTable').DataTable().column( 3 ).search(
            'Telefono'
    ).draw();
    });
    
    $('#col3_filterVMAC').on('click',function(){
        $('#visitTable').DataTable().column( 3 ).search(
            'Virtual Machine'
    ).draw();
    });
    
    $('#col3_filterServer').on('click',function(){
        $('#visitTable').DataTable().column( 3 ).search(
            'Server'
    ).draw();
    });
    
    $('#col4_filter').on('change',function(){
        $('#visitTable').DataTable().column( 4 ).search(
            $( "#col4_filter" ).val()
    ).draw();
    });
    
    
    $('#visitTable')
		.removeClass( 'display' )
		.addClass('table table-striped table-bordered');
        
    $("#ajaxresponse").children().remove();


    // reinitialize the datatable
    $('#rankings').dataTable( {
    "sDom":'t<"bottom"filp><"clear">',
    "bAutoWidth": true,
    "responsive": true,
    "sPaginationType": "full_numbers",
        "aoColumns": [ 
        { "bSortable": false, "sWidth": "10px" },
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
        ]

    } 
    );
} );

