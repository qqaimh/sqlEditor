import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';

import { SqlEditorModule } from 'sql-editor';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    SqlEditorModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
