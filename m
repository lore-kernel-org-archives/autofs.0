From: Ian Kent <raven@themaw.net>
Subject: Re: autofs unmount don't work with symbolic links
Date: Tue, 2 Nov 2004 20:02:14 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0411022001070.2952@raven-wl.themaw.net>
References: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua> 
 <200410302317.04738.vda@port.imtp.ilyichevsk.odessa.ua> 
 <1099300553.19050.241.camel@IAPonomarenko.isd.dp.ua> 
 <200411011332.06171.vda@port.imtp.ilyichevsk.odessa.ua> 
 <Pine.LNX.4.58.0411020719151.7571@wombat.indigo.net.au>
 <1099387308.2199.28.camel@IAPonomarenko.isd.dp.ua>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1099387308.2199.28.camel@IAPonomarenko.isd.dp.ua>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Ponomarenko <apon@isd.dp.ua>
Cc: autofs@linux.kernel.org

On Tue, 2 Nov 2004, Alexander Ponomarenko wrote:

> /etc/auto.master is
> 
> /var/autofs/local       /etc/auto.local         --timeout=30
> /usr/var/autofs/remote  /etc/auto.remote        --timeout=300
> /usr/var/autofs/mks     /etc/auto.mks           --timeout=300
> 
> where /var is simbolic link to /usr/var. All mounts from /etc/auto.local
> don't unmounts on expiration time but mounts from /etc/auto.remote and
> /etc/auto.mks works fine (unmounts on expiration time). The situation is
> the same as for the version 3 of autofs kernel module, as for the
> version 4. I can add syslog logs if needed (too mach for posting).

Can you make log (produced by using --debug) available somewhere?

Ian
