From: raven@themaw.net
Subject: Re: [PATCH 0/5] rediffed patches
Date: Sun, 13 Feb 2005 21:25:29 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502132122240.1843@donald.themaw.net>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
In-Reply-To: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: autofs@linux.kernel.org

On Fri, 11 Feb 2005, Denis Vlasenko wrote:

> Originally done against 4.1.3. Rediffed against 4.1.4_beta1 now
>
> Please comment /apply

All that glitters is not gold.

My Ultra SPARC doesn't like the logging patches much.
Managed to carsh automount in a flash.

Still it could be my fault I'll check further.

Feb 13 21:20:14 donald automount[1786]: starting automounter version , path = (null), maptype = (null), mapname = (null)
Feb 13 21:20:14 donald automount[1786]: mount(bind): bind_works = -268438712
Feb 13 21:20:14 donald automount[1786]: using kernel protocol version -268437552.00
Feb 13 21:20:14 donald automount[1786]: using timeout -268437552 seconds; freq 0 secs
Feb 13 21:20:14 donald automount[1786]: ghosting enabled
Feb 13 21:20:30 donald automount[1786]: sig -268438664 switching from 0 to 0
Feb 13 21:20:30 donald automount[1786]: get_pkt: state -268438184, next 8
Feb 13 21:20:30 donald automount[1786]: st_expire(): state = -268438288
Feb 13 21:20:30 donald automount[1786]: expire_proc: exp_proc=-268438808
Feb 13 21:20:30 donald automount[1786]: handle_child: got pid -268439072, sig 0 (0), stat 0
Feb 13 21:20:30 donald automount[1786]: sigchld: exp -268439072 finished, switching from 0 to 0
Feb 13 21:20:30 donald automount[1786]: get_pkt: state -268438184, next 8
Feb 13 21:20:30 donald automount[1786]: st_ready(): state = -268438288
Feb 13 21:20:38 donald automount[1786]: handle_packet: type = -268437928
Feb 13 21:20:38 donald automount[1786]: process -268445208 got unexpected signal 0!
Feb 13 21:20:38 donald automount[1786]: sig -268445208 switching from 0 to 0

Ian
