{#

OPNsense® is Copyright © 2014 – 2025 by Deciso B.V.
This file is Copyright © 2017 by Fabian Franz
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

#}

<script>

    function quagga_update_status() {
      updateServiceControlUI('quagga');
    }

    $( document ).ready(function() {
        mapDataToFormUI({'frm_ospf_settings':"/api/quagga/ospfsettings/get"}).done(function(data){
            formatTokenizersUI();
            $('.selectpicker').selectpicker('refresh');
            updateServiceControlUI('quagga');
        });

        $("#reconfigureAct").SimpleActionButton({
            onPreAction: function() {
                const dfObj = new $.Deferred();
                saveFormToEndpoint("/api/quagga/ospfsettings/set", 'frm_ospf_settings', function () { dfObj.resolve(); }, true, function () { dfObj.reject(); });
                return dfObj;
            },
            onAction: function(data, status) {
                updateServiceControlUI('quagga');
            }
        });

        $("#{{formGridEditOSPFNeighbor['table_id']}}").UIBootgrid({
            'search':'/api/quagga/ospfsettings/search_neighbor',
            'get':'/api/quagga/ospfsettings/get_neighbor/',
            'set':'/api/quagga/ospfsettings/set_neighbor/',
            'add':'/api/quagga/ospfsettings/add_neighbor/',
            'del':'/api/quagga/ospfsettings/del_neighbor/',
            'toggle':'/api/quagga/ospfsettings/toggle_neighbor/'
        });
        $("#{{formGridEditNetwork['table_id']}}").UIBootgrid({
            'search':'/api/quagga/ospfsettings/searchNetwork',
            'get':'/api/quagga/ospfsettings/getNetwork/',
            'set':'/api/quagga/ospfsettings/setNetwork/',
            'add':'/api/quagga/ospfsettings/addNetwork/',
            'del':'/api/quagga/ospfsettings/delNetwork/',
            'toggle':'/api/quagga/ospfsettings/toggleNetwork/'
        });
        $("#{{formGridEditInterface['table_id']}}").UIBootgrid({
            'search':'/api/quagga/ospfsettings/searchInterface',
            'get':'/api/quagga/ospfsettings/getInterface/',
            'set':'/api/quagga/ospfsettings/setInterface/',
            'add':'/api/quagga/ospfsettings/addInterface/',
            'del':'/api/quagga/ospfsettings/delInterface/',
            'toggle':'/api/quagga/ospfsettings/toggleInterface/'
        });
        $("#{{formGridEditPrefixLists['table_id']}}").UIBootgrid({
            'search':'/api/quagga/ospfsettings/searchPrefixlist',
            'get':'/api/quagga/ospfsettings/getPrefixlist/',
            'set':'/api/quagga/ospfsettings/setPrefixlist/',
            'add':'/api/quagga/ospfsettings/addPrefixlist/',
            'del':'/api/quagga/ospfsettings/delPrefixlist/',
            'toggle':'/api/quagga/ospfsettings/togglePrefixlist/'
        });
        $("#{{formGridEditRouteMaps['table_id']}}").UIBootgrid({
            'search':'/api/quagga/ospfsettings/searchRoutemap',
            'get':'/api/quagga/ospfsettings/getRoutemap/',
            'set':'/api/quagga/ospfsettings/setRoutemap/',
            'add':'/api/quagga/ospfsettings/addRoutemap/',
            'del':'/api/quagga/ospfsettings/delRoutemap/',
            'toggle':'/api/quagga/ospfsettings/toggleRoutemap/'
        });
        $("#{{formGridEditRedistribution['table_id']}}").UIBootgrid({
            'search':'/api/quagga/ospfsettings/searchRedistribution',
            'get':'/api/quagga/ospfsettings/getRedistribution/',
            'set':'/api/quagga/ospfsettings/setRedistribution/',
            'add':'/api/quagga/ospfsettings/addRedistribution/',
            'del':'/api/quagga/ospfsettings/delRedistribution/',
            'toggle':'/api/quagga/ospfsettings/toggleRedistribution/'
        });

        const $header = $(".bootgrid-header[id*='{{formGridEditRedistribution['table_id']}}']");
        if ($header.length) {
            $header.find("div.actionBar").parent().prepend(
                '<td class="col-sm-2 theading-text">' +
                '<span class="fa fa-info-circle text-muted" style="margin-right: 5px;"></span>' +
                '<strong>{{ lang._("Route Redistribution") }}</strong>' +
                '</td>'
            );
        }

    });
</script>

<style>
    /* Some trickery to make the redistribution grid look like its part of the base form */
    .bootgrid-header[id*='{{ formGridEditRedistribution['table_id'] }}'] {
        padding-left: 10px;
    }
    #{{ formGridEditRedistribution['table_id'] }}.bootgrid-table {
        margin-left: 25%;
        width: 75%;
    }
    .bootgrid-footer[id*='{{ formGridEditRedistribution['table_id'] }}'] {
        margin-left: 24%;
    }
</style>

<!-- Navigation bar -->
<ul class="nav nav-tabs" data-tabs="tabs" id="maintabs">
    <li class="active"><a data-toggle="tab" href="#general">{{ lang._('General') }}</a></li>
    <li><a data-toggle="tab" href="#neighbors">{{ lang._('Neighbors') }}</a></li>
    <li><a data-toggle="tab" href="#networks">{{ lang._('Networks') }}</a></li>
    <li><a data-toggle="tab" href="#interfaces">{{ lang._('Interfaces') }}</a></li>
    <li><a data-toggle="tab" href="#prefixlists">{{ lang._('Prefix Lists') }}</a></li>
    <li><a data-toggle="tab" href="#routemaps">{{ lang._('Route Maps') }}</a></li>
</ul>
<div class="tab-content content-box tab-content">
    <!-- Tab: General -->
    <div id="general" class="tab-pane fade in active">
        {{ partial("layout_partials/base_form",['fields':generalForm,'id':'frm_ospf_settings'])}}
        {{ partial('layout_partials/base_bootgrid_table', formGridEditRedistribution)}}
    </div>
    <!-- Tab: Neighbors -->
    <div id="neighbors" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridEditOSPFNeighbor)}}
    </div>
    <!-- Tab: Networks -->
    <div id="networks" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridEditNetwork)}}
    </div>
    <!-- Tab: Interfaces -->
    <div id="interfaces" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridEditInterface)}}
    </div>
    <!-- Tab: Prefixlists -->
    <div id="prefixlists" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridEditPrefixLists)}}
    </div>
    <!-- Tab: Routemaps -->
    <div id="routemaps" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridEditRouteMaps)}}
    </div>
</div>
{{ partial('layout_partials/base_apply_button', {'data_endpoint': '/api/quagga/service/reconfigure', 'data_service_widget': 'quagga'}) }}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditOSPFNeighbor,'id':formGridEditOSPFNeighbor['edit_dialog_id'],'label':lang._('Edit Neighbor')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditNetwork,'id':formGridEditNetwork['edit_dialog_id'],'label':lang._('Edit Network')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditInterface,'id':formGridEditInterface['edit_dialog_id'],'label':lang._('Edit Interface')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditPrefixLists,'id':formGridEditPrefixLists['edit_dialog_id'],'label':lang._('Edit Prefix Lists')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditRouteMaps,'id':formGridEditRouteMaps['edit_dialog_id'],'label':lang._('Edit Route Maps')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditRedistribution,'id':formGridEditRedistribution['edit_dialog_id'],'label':lang._('Edit Route Redistribution')])}}
