import { NgModule } from '@angular/core';

import { SqlEditorComponent } from './sql-editor/sql-editor.component';
import { EditorConfigService } from './services/editor-config.service';


@NgModule({
  declarations: [SqlEditorComponent],
  imports: [
  ],
  providers: [EditorConfigService],
  exports: [SqlEditorComponent]
})
export class SqlEditorModule { }
