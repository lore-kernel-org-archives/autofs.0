From: "surya " <surya_prabhakar@linuxmail.org>
Subject: Re: Autofs problem (migration from sun to linux )
Date: Sun, 14 Mar 2004 17:19:11 +0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040314121911.D66BE23979@ws5-3.us4.outblaze.com>
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
Cc: autofs@linux.kernel.org

Dear Ian ,
     Thank you for your help . But unfortunately it did not solve my problem . I run autofs modular . So I removed existing one and compiled the autofs4 tar file and also compiled the patch module(autofs4-2.4-module-20031201.tar.bz2 ) . It got installed , I restarted autofs but no luck . Most of my maps comes from NIS . still I cant see any directories . Kindly tell me is there something else which I need to check .

awaiting your reply,

rgds
Surya .



----- Original Message -----
From: Ian Kent <raven@themaw.net>
Date: Sun, 7 Mar 2004 19:21:50 +0800 (WST)
To: surya <surya_prabhakar@linuxmail.org>
Subject: Re: [autofs] Autofs problem (migration from sun to linux )

> On Sun, 7 Mar 2004, surya  wrote:
> 
> > Dear All ,
> >           We are migrating from sun to linux . The problem faced is , all the mounted directories are shown  by default in sun . But in linux the directories are not shown until they are accessed . Is there a way wherein all the directories are shown by default in linux like sun .
> > 
> 
> Try looking at 
> http://www.kernel.org/pub/linux/daemons/autofs/v4/
> 
> You need the kernel module update also.
> 
> Ian
> 



rgds
surya

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
