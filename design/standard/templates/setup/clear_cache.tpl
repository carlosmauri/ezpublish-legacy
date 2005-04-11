{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{let selected_cache_type=ezpreference( 'admin_clearcache_type' )
     caches_list=array( array( 'All', 'All caches', false ),
                        array( 'Content', 'Content', false ),
                        array( 'ContentNode', 'Content - node', true ),
                        array( 'ContentSubtree', 'Content - subtree', true ),
                        array( 'Template', 'Template', false ),
                        array( 'TemplateContent', 'Template & content', false),
                        array( 'Ini', 'Ini settings', false ),
                        array( 'Static', 'Static', false ) )}

<form name="clearcache" action={'setup/cachetoolbar'|ezurl} method="post">
<select{eq( $ui_context, 'edit' )|choose( '', ' disabled="disabled"' )} name="CacheTypeValue">
   {section loop=$caches_list}
      {section show=eq( $:item.2, false )}
        <option{eq( $selected_cache_type, $:item.0 )|choose( '', ' selected="selected"' )} value="{$:item.0}">{$:item.1|i18n( 'design/admin/pagelayout' )|wash}</option>
      {section-else}
       {section show=is_set( $module_result.content_info )}
        <option{eq( $selected_cache_type, $:item.0 )|choose( '', ' selected="selected"' )} value="{$:item.0}">{$:item.1|i18n( 'design/admin/pagelayout' )|wash}</option>
       {/section}
      {/section}
   {/section}
</select>
    {section show=is_set( $module_result.content_info )}
      <input type="hidden" name="NodeID" value="{$module_result.content_info.node_id}" />
      <input type="hidden" name="ObjectID" value="{$module_result.content_info.object_id}" />
    {/section}
    <br/>
    <input {eq( $ui_context, 'edit' )|choose( 'class="button"', 'class="button-disabled"' )}{eq( $ui_context, 'edit' )|choose( '', ' disabled="disabled"' )} type="submit" name="ClearCacheButton" value="{'Clear'|i18n( 'design/admin/pagelayout' )}" />
</form>
{/let}
