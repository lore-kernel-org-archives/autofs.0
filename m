From: toto <guillaume@apostoly.com>
Subject: Re: stat -L triggering mount (behavior change starting =?utf-8?b?d2l0aAkyLjYuMzgtcmMxKQ==?=
Date: Tue, 26 Mar 2013 12:56:55 +0000 (UTC)
Message-ID: <loom.20130326T135119-763@post.gmane.org>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

Leonardo Chiquitto <leonardo.lists <at> gmail.com> writes:

> 
> Hello,
> 
> After the update to 2.6.38, I noticed that AutoFS started to mount volumes
> at times it normally wouldn't. More specifically, "ls -la" inside an AutoFS
> mount point will trigger the mount of all available maps.
__________
> autofs mailing list
> autofs <at> linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 

Hi,

When you are saying that "ls -la" should not trigger
 the automounting of the volumes inside the directory,
what would be then the good command line to 
trigger the mounting of volumes declared in auto.master ?
I am using Mac OS X 10.8.3 and by default, 
the elements defined in automaster are mounted when 
accessed by an application (like the Finder,
 which is if you don't know the file manager of OS X), but how 
then to trigger the silent mounting at startup 
with a shell script ? Are there parameters to pass to "mount" 
command to say "mount this folder 
NOW as defined in auto master" ?
Thanking you in advance for your help. 
Best regards,

