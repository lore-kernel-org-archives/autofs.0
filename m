From: Ian Kent <raven@themaw.net>
Subject: Re: Solaris style +auto_home syntax
Date: Thu, 29 Jul 2004 23:38:20 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407292333410.2627@raven.themaw.net>
References: <4108F19F.6040505@ks.informatik.uni-kiel.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4108F19F.6040505@ks.informatik.uni-kiel.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Schmidt <hbs@ks.informatik.uni-kiel.de>
Cc: autofs@linux.kernel.org

On Thu, 29 Jul 2004, Henrik Schmidt wrote:

> 
> Hi,
> 
> I want to use something like this
> -----------------------------------------
> 
> auto.master :
> /home	/etc/auto.home
> 
> 
> auto.home :
> localuser  localhost:/export/home/&
> +auto_home
> ------------------------------------------
> 
> +auto_home should add the entries of my Solaris nisplus auto_home map.
> 
> I use automount 3.1.7 and have nisplus on linux fully operational.
> 
> I can do
> 
> auto.master :
> /home nisplus auto_home
> 
> and it will work. But I want to merge local mounts from /export/home
> with network mounts from nisplus. The +auto_home syntax is working on 
> Solaris clients but not on my SuSE 9.1 clients. Any hint or is just not
> supported ?

Nop. Not supported.

> 
> Second question : How do I use direct maps with automount on linux ?
> Will autofs4 support it ?

Direct mounts are partially supported in autofs-4.1 and above but not for 
nisplus.

I have plans to setup a nisplus server so I can work on this but even 
after quite a while I have not found time to do so. Sorry.

Ian
