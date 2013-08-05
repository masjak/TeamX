private function callMyExe():void
		{
			//使用静态属性 NativeApplication.nativeApplication 获取应用程序的 NativeApplication 实例
			//指定在关闭所有窗口后是否应自动终止应用程序。
			/*当 autoExit 为 true（默认值）时，如果关闭了所有窗口，则应用程序将终止。调度 exiting 和 exit 事件。如果 autoExit 为 false，则必须调用 NativeApplication.nativeApplication.exit() 才能终止应用程序。*/
			NativeApplication.nativeApplication.autoExit=true;
			//调用的文件
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