private function callMyExe():void
		{
			//ʹ�þ�̬���� NativeApplication.nativeApplication ��ȡӦ�ó���� NativeApplication ʵ��
			//ָ���ڹر����д��ں��Ƿ�Ӧ�Զ���ֹӦ�ó���
			/*�� autoExit Ϊ true��Ĭ��ֵ��ʱ������ر������д��ڣ���Ӧ�ó�����ֹ������ exiting �� exit �¼������ autoExit Ϊ false���������� NativeApplication.nativeApplication.exit() ������ֹӦ�ó���*/
			NativeApplication.nativeApplication.autoExit=true;
			//���õ��ļ�
			file=file.resolvePath("E:/workPath/work/XLib/TeamX/tools/ATF Tools/Windows/png2atf.exe");
			nativeProcessStartupInfo=new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable=file;
			var args:Vector.<String> = new Vector.<String>();
			args.push("-c");
			args.push("-i");
			args.push("E:/workPath/work/XLib/TeamX/tools/ATF Tools/Windows/0_0.png");
			args.push("-o");
			args.push("E:/workPath/work/XLib/TeamX/tools/ATF Tools/Windows/0_1.atf");
			
			nativeProcessStartupInfo.arguments = args;
			var process:NativeProcess = new NativeProcess();
			process.start(nativeProcessStartupInfo);
		}