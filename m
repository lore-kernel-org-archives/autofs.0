From: "Takashi Yoshizawa" <mz711@hotmail.com>
Subject: Re: Is the "program" format correct ?
Date: Wed, 11 Aug 2004 16:16:09 +0900
Sender: autofs-bounces@linux.kernel.org
Message-ID: <BAY18-F2u57RmVHsqWP000188f0@hotmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Andreas Neuper wrote:
>~# /etc/auto.cat
>
>floppy  -fstype=auto                            :/dev/fd0
>video   -fstype=nfs,rw,rsize=8192,wsize=8192    ok:/home/video
>

I'm also using automounter program map.
It should behave like this:
~# /etc/auto.cat video
-fstype=nfs,rw,rsize=8192,wsize=8192    ok:/home/video

>~# echo "/tmp/cat       /etc/auto.cat" >> /etc/auto.master

~# echo "/tmp/cat       program:/etc/auto.cat" >> /etc/auto.master

Takashi Yoshizawa

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail
