/** ------------------------------------------
 main.js
 
 javascript main functions
 
 JY Martin
 Ecole Centrale Nantes
 ------------------------------------------ */

// -----------------------------------------------------------------------------
/**
 * Launch ajax call
 * @param {type} action
 * @param {type} data
 * @param {type} applySuccess
 * @returns {undefined}
 */
function ajaxCall(action, data, applySuccess) {
  // id "connexion" is ALWAYS defined in header
  var id_code = document.getElementById("connexion");
  data.connexion = id_code.value;
  data.action = action;

  $.ajax({
    url: "ajax.do",
    data: data,
    method: "POST",
    async: false,
    success: function (result) {
      // Switch to object
      var jsonResult;
      if (result.ok === undefined) {
        jsonResult = JSON.parse(result);
      } else {
        jsonResult = result;
      }
      // Check result
      if (jsonResult.ok === 1) {
        applySuccess(jsonResult, data);
      } else {
        console.log("refused call " + action);
      }
    },
    error: function (resultat, statut, erreur) {
      console.log("error call " + action + " result = " + resultat + statut + erreur);
    }
  });
}

// -----------------------------------------------------------------------------
/**
 * Drag and drop functions
 */

/**
 * get target from event
 * @param {type} ev
 * @returns {.target.parentNode.parentNode|.ev.target.parentNode|getTarget.target}
 */
function getTarget(ev) {
  var target = ev.target;
  while ((target !== null) && (target !== undefined) && (target.id.substring(0, 4) !== "list")) {
    target = target.parentNode;
  }
  return target;
}

/**
 * to manage drops
 * @param {type} ev
 */
function allowDrop(ev) {
  ev.preventDefault();
}


/**
 * drag element
 * @param {type} ev : save dragged element somewhere
 */
function drag(ev) {
  ev.dataTransfer.setData("dragelt", ev.target.id);
}

/**
 * drop element
 * @param {type} ev
 */
function drop(ev) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("dragelt");
  var dragElt = document.getElementById(data);
  var target = getTarget(ev);
  if ((target !== null) && (target !== undefined) && (dragElt !== null)) {
    target.appendChild(dragElt);
  }
}


/**
 * rename dropped element in the new list
 * @param {type} ev
 */
function dropAndRename(ev, oldName, newName) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("dragelt");
  var dragElt = document.getElementById(data);
  var target = getTarget(ev);
  if ((target !== null) && (target !== undefined) && (dragElt !== null)) {
    target.appendChild(dragElt);

    replaceElements(target, oldName, newName);
  }
}


/**
 * rename dropped element in the new list, and renumber it
 * @param {type} ev
 * @param {string} oldName
 * @param {string} newName
 */
function dropAndRenameAndRenumber(ev, oldName, newName) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("dragelt");
  var dragElt = document.getElementById(data);
  var target = getTarget(ev);
  if ((target !== null) && (target !== undefined) && (dragElt !== null)) {
    target.appendChild(dragElt);

    replaceAndRenameElements(target, 0, oldName, newName);
  }
}

// -----------------------------------------------------------------------------
function filterList(theListID, theInputId) {
  if ((theListID !== null) && (theListID !== undefined) && (theInputId !== null) && (theInputId !== undefined)) {
    var input = document.getElementById(theInputId);
    var list = document.getElementById(theListID);
    if ((input !== null) && (input !== undefined) && (list !== null) && (list !== undefined)) {
      var filter = input.value.toUpperCase();
      var elements = list.childNodes;
      for (var i = 0; i < elements.length; i++) {
        var element = elements[i];
        if (element.nodeType === Node.ELEMENT_NODE) {
          if (element.tagName === "DIV") {
            var elementContent = getTextChild(element);
            if (elementContent.toUpperCase().indexOf(filter) > -1) {
              element.style.display = "";
            } else {
              element.style.display = "none";
            }
          }
        }
      }
    }
  }
}

// -----------------------------------------------------------------------------
// DATATABLE Tools

var myDatatableButtons = new Array();
var myDatatableOptions = new Array();

/**
 Display table using Datatable
 */
function showDataTable(tableName) {
  var theTable = document.getElementById(tableName);
  if (theTable !== null) {
    let spinner = document.getElementById("fountainG");
    if (spinner !== null) {
      spinner.parentElement.removeChild(spinner);
    }
    theTable.style.visibility = "visible";
    theTable.style.width = "100%";
  }
}

function addDataTableButtonCopy() {
  myDatatableButtons.push({
    extend: 'copy',
    exportOptions: {rows: {selected: true}}
  });
}

function addDataTableButtonCsv() {
  myDatatableButtons.push({
    extend: 'csv',
    exportOptions: {rows: {selected: true}}
  });
}

function addDataTableButtonPrint() {
  myDatatableButtons.push({
    extend: 'print',
    exportOptions: {rows: {selected: true}}
  });
}

function addDataTableButtonExcel() {
  myDatatableButtons.push({
    extend: 'excelHtml5',
    exportOptions: {rows: {selected: true}},
    customize: function (xlsx) {
      var sheet = xlsx.xl.worksheets['sheet1.xml'];
      $('row c[r^="C"]', sheet).attr('s', '2');
    }
  });
}

function addDataTableButtonSelectAll() {
  myDatatableButtons.push('selectAll');
}

function addDataTableButtonDeselectAll() {
  myDatatableButtons.push('selectNone');
}

function addDataTableButtonImport(itemName) {
  myDatatableButtons.push({
    text: 'Import',
    action: function (e, dt, node, conf) {
      var formRef = document.getElementById("formImporter");
      formRef.action = itemName + "Import.do";
      var element = document.querySelector("#importFile");
      element.click();
    }
  });
}

function addDataTableButtonExport(itemName) {
  myDatatableButtons.push({
    text: 'Export',
    action: function (e, dt, node, conf) {
      var formRef = document.getElementById("formExporter");
      formRef.action = itemName + "Export.do";
      // formRef.target = "_blank";
      formRef.submit();
    }
  });
}

function addDataTableButtonPrint(itemName) {
  myDatatableButtons.push({
    text: 'Print',
    action: function (e, dt, node, conf) {
      var formRef = document.getElementById("formExporter");
      formRef.action = itemName + "Print.do";
      // formRef.target = "_blank";
      formRef.submit();
    }
  });
}

function addDataTableButtonOther(itemName, buttonName, actionScriptName, paramValue) {
  myDatatableButtons.push({
    text: buttonName,
    action: function (e, dt, node, conf) {
      var actionName = itemName + actionScriptName;
      // var dataValue = new Object();
      var curAction = itemName + "List";
      var dataValue = paramValue;

      launchAction(actionName, dataValue, curAction);
    }
  });
}

function addDataTableButtonNew(itemName) {
  myDatatableButtons.push({
    text: 'NEW',
    action: function (e, dt, node, conf) {
      create(itemName, -1);
    }
  });
}

function setDataTableRemovePaginate() {
  myDatatableOptions["paginate"] = 0;
}

function setDataTableRemoveResponsive() {
  myDatatableOptions["responsive"] = 0;
}

function buildTable(tableName) {
  // Structure table
  let datatableOption = new Object();
  datatableOption.fnDrawCallback = function (oSettings) {
    showDataTable(tableName);
  };
  datatableOption.rowReorder = {selector: 'td:nth-child(1)'};
  if (myDatatableOptions["responsive"] === 0) {
    datatableOption.responsive = false;
  } else {
    datatableOption.responsive = true;
  }
  datatableOption.lengthChange = true;
  if (myDatatableOptions["paginate"] !== 0) {
    datatableOption.bPaginate = true;
    datatableOption.lengthMenu = [[10, 50, 100, -1], [10, 50, 100, "All"]];
    datatableOption.pageLength = 10;
  } else {
    datatableOption.paging = false;
    datatableOption.bPaginate = false;
  }
  datatableOption.dom = 'Bfrtipl';
  datatableOption.buttons = myDatatableButtons;
  datatableOption.select = false;
  datatableOption.ordering = true;
  datatableOption.info = true;
  
  let table = $('#' + tableName).DataTable(datatableOption);

  return table;
}

function hideTableLength(tableName) {
  var blocLength = document.getElementById(tableName + "_length");
  if (blocLength !== null) {
    var label = blocLength.firstElementChild;
    var select = label.firstElementChild;
    while ((select !== null) && (select !== undefined) && (select.nodeType !== 1)) {
      select = select.el.nextElementSibling;
    }
    if ((select !== null) && (select !== undefined)) {
      select.selectedIndex = 3;
      var event = new Event('change');
      select.dispatchEvent(event);
      blocLength.style.display = "none";
    }
  }
  var blocPaginate = document.getElementById(tableName + "_paginate");
  if (blocPaginate !== null) {
    blocPaginate.style.display = "none";
  }
}