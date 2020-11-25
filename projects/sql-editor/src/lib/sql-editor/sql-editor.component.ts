/// <reference path="../../../../../node_modules/monaco-editor/monaco.d.ts" />
import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';

import { EditorConfigService } from '../services/editor-config.service';

let loadedMonaco = false;
let loadPromise: Promise<void>;

@Component({
  selector: 'warp-sql-editor',
  templateUrl: './sql-editor.component.html',
  styleUrls: ['./sql-editor.component.scss']
})
export class SqlEditorComponent implements OnInit {
  @ViewChild('editorContainer', {static: true}) editorContainer: ElementRef;

  code =  `
  // Type source code in your language here...
  class MyClass {
    @attribute
    void main() {
      Console.writeln( "Hello Monarch world\\n");
    }
  }
  `;

  codeEditorInstance: monaco.editor.IStandaloneCodeEditor;

  constructor(private editorConfigService: EditorConfigService) { }

  ngOnInit(): void {
    if (loadedMonaco) {
      // Wait until monaco editor is available
      loadPromise.then(() => {
        this.initMonaco();
      });
    } else {
      loadedMonaco = true;
      loadPromise = new Promise<void>((resolve: any) => {
        if (typeof ((<any>window).monaco) === 'object') {
          resolve();
          return;
        }
        const onAmdLoader: any = () => {
          // Load monaco
          (<any>window).require.config({ paths: { 'vs': 'assets/monaco/vs' } });

          (<any>window).require(['vs/editor/editor.main'], () => {
            this.initMonaco();
            resolve();
          });
        };

        // Load AMD loader if necessary
        if (!(<any>window).require) {
          const loaderScript: HTMLScriptElement = document.createElement('script');
          loaderScript.type = 'text/javascript';
          loaderScript.src = 'assets/monaco/vs/loader.js';
          loaderScript.addEventListener('load', onAmdLoader);
          document.body.appendChild(loaderScript);
        } else {
          onAmdLoader();
        }
      });
    }
  }

  initMonaco(): void {
    // configure the monaco editor to understand custom language - customLang
    monaco.languages.register(this.editorConfigService.getCustomLangExtensionPoint());
    monaco.languages.setMonarchTokensProvider('CustomLang', this.editorConfigService.getCustomLangTokenProviders());
    // monaco.editor.defineTheme('customLangTheme', this.ConfigService.getCustomLangTheme());   // add your custom theme here

    this.codeEditorInstance = monaco.editor.create(this.editorContainer.nativeElement, {
      value: this.code,
      language: 'CustomLang',
      theme: 'vs-dark'
      // theme: 'customLangTheme'
    });

  }

}
