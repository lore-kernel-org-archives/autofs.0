From: "surya " <surya_prabhakar@linuxmail.org>
Subject: Summary of autofs migration from Sun to Linux (resolved)
Date: Sun, 14 Mar 2004 20:39:30 +0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040314153930.A51593982E7@ws5-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, mark.laforest@amd.com

Dear Ian / All  , 
              First of all Thank you so much Ian for your time to resolve our problem . 

Summary is 

just download 2 files from the below site

http://www.kernel.org/pub/linux/daemons/autofs/v4/

download the below files

autofs-4.1.0.tar.gz 
autofs4-2.4-module-20031201.tar.gz 

1) remove your existing autofs rpm ( if applicable)
2) untar the autofs-4.1.0.tar.gz and compile it ( ./configure, make ,make install) 
3) back up your previous module if you want (/lib/modules/<kernel-dir>/kernel/fs/autofs/autofs.o)
4) Untar autofs4-2.4-module-20031201.tar.gz then do (adjust your kernelpath & macro(read the README) , make ,make install) 
     After this need to add an option to the master map like this 

              /home	/etc/auto.home --ghost (  /home	/etc/auto.home --ghost ) 
   You can also pass this " --ghost " option in the /etc/init.d/autofs file .
   There is an option in this file called  daemonoptions append the entry
   
   eg:
   daemonoptions='--ghost'

    This will append the option to the automount daemon .

5) Restart your autofs service .

    That will solve the problem .


rgds

Surya Prabhakar N ,
Technical Specialist ,
Strategy & Deployment Team ,
Wipro Limited ,
Bangalore - India.
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
