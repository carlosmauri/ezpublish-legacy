<form action={concat("/content/translate/",$object.id,"/",$edit_version)|ezurl} method="post">

<h1>Translating '{$object.name}'</h1>

{section show=$validation.processed}
    {section name=UnvalidatedAttribute loop=$validation.attributes show=$validation.attributes}

    <div class="warning">
    <h3 class="warning">Input did not validate</h3>
    <ul>
    	<li>{$UnvalidatedAttribute:item.identifier}: {$UnvalidatedAttribute:item.name} ({$UnvalidatedAttribute:item.id})</li>
    </ul>
    </div>

    {section-else}

    <div class="feedback">
    <h3 class="feedback">{$validation.locale.intl_language_name} input was stored successfully</h3>
    </div>

    {/section}
{/section}

{section show=$is_remove_active}
<!-- Translation removal start -->

<p>
Remove the following translations from '{$object.name}'?
</p>

<br/>

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
  <th width="10%">Locale</th>
  <th width="90%">Language</th>
</tr>

{section name=Language loop=$remove_language_list sequence=array("bglight","bgdark")}
<tr>
  <td class="{$Language:sequence}">
    {$Language:item.language_code}
  </td>
  <td class="{$Language:sequence}">
  {section show=$Language:item.locale.is_valid}
    {$Language:item.locale.intl_language_name}
  {section-else}
    (No locale information available)
  {/section}
  </td>
  <td class="{$Language:sequence}">
    <input type="hidden" name="RemoveLanguageArray[]" value="{$Language:item.language_code}" />
  </td>
</tr>
{/section}
</table>

<br/>

<input type="hidden" name="TranslationLanguageEdit" value="{$translation_language}" />

<input type="submit" name="RemoveLanguageConfirmationButton" value="{'Yes'|i18n('content/object')}" />
<input type="submit" name="RemoveLanguageCancelButton" value="{'No'|i18n('content/object')}" />

<!-- Translation removal end -->

{section-else}

{let name=Translation
     translation_list=fetch('content','non_translation_list',hash('object_id',$object.id,'version',$edit_version))}
{section show=$Translation:translation_list}

<h2>Translate into:</h2>
<select name="SelectedLanguage" >
  {section loop=$Translation:translation_list}
<option value="{$Translation:item.locale_code}">{$Translation:item.intl_language_name}</option>
  {/section}
</select>
&nbsp;
<input type="submit" name="AddLanguageButton" value="{'Add'|i18n('content/object')}" />

{/section}
{/let}

{let name=Translation
     language_index=0
     translation_list=$content_version.translation_list}
{section show=$Translation:translation_list}

<h2>Translations</h2>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
  <th width="2%"><input type="submit" name="EditLanguageButton" value="{'Translate'|i18n('content/object')}" /></th>
  <th width="10%">Locale</th>
  <th width="86%">Language</th>
  <th width="2%"><input type="submit" name="RemoveLanguageButton" value="{'Remove'|i18n('content/object')}" /></th>
</tr>

{section loop=$Translation:translation_list}
  {section show=eq($translation_language,$Translation:item.language_code)}
    {set language_index=$Translation:index}
  {/section}
{/section}

{section loop=$Translation:translation_list sequence=array("bglight","bgdark")}
<tr>
  <td class="{$Translation:sequence}">
    <input type="radio" name="EditSelectedLanguage" value="{$Translation:item.language_code}" {section show=eq($Translation:index,$Translation:language_index)}checked="checked"{/section} />
  </td>
  <td class="{$Translation:sequence}">
    {$Translation:item.language_code}
  </td>
  <td class="{$Translation:sequence}">
  {section show=$Translation:item.locale.is_valid}
    {$Translation:item.locale.intl_language_name}
  {section-else}
    (No locale information available)
  {/section}
  </td>
  <td class="{$Translation:sequence}">
    <input type="checkbox" name="RemoveLanguageArray[]" value="{$Translation:item.language_code}" />
  </td>
</tr>
{/section}
</table>

{/section}

{/let}

{section show=$translation_language}

<br/>

<input type="hidden" name="TranslationLanguageEdit" value="{$translation_language}" />

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
  <th width="50%">{$translation_locale.intl_language_name} ({$translation_locale.locale_code})</th>
  <th width="50%">{$original_locale.intl_language_name} ({$original_locale.locale_code})</th>
</tr>

{section name=ContentAttribute loop=$content_attributes}
{section-exclude match=$content_attribute_map[$ContentAttribute:item.contentclassattribute_id].contentclass_attribute.data_type.properties.translation_allowed|not}

<tr>
  <td>
    <label>{$ContentAttribute:item.contentclass_attribute.name}:</label><div class="labelbreak"></div>
    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$ContentAttribute:item.id}" />
  </td>
  <td>
    <label>{$ContentAttribute:item.contentclass_attribute.name}:</label><div class="labelbreak"></div>
  </td>
</tr>
<tr>
  </td>
  <!-- Translated attributes start -->
  <td>
  {let translation=$content_attribute_map[$ContentAttribute:item.contentclassattribute_id]}
    {section show=$ContentAttribute:translation}
      {attribute_edit_gui attribute=$ContentAttribute:translation}
    {/section}
  {/let}

  </td>
  <!-- Translated attributes end -->

  <!-- Original attributes start -->
  <td valign="top">
    {attribute_view_gui attribute=$ContentAttribute:item}<br />
  </td>
  <!-- Original attributes end -->
</tr>

{/section}

</table>

<br />
<input type="submit" name="StoreButton" value="Store" />
<input type="submit" name="EditObjectButton" value="Edit Object" />

{section-else}

<br />
<input type="submit" name="EditObjectButton" value="Edit Object" />

{/section}

{/section}

</form>
