From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: multiple servers per automount
Date: Wed, 08 Oct 2003 17:28:03 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F848163.2050803@sun.com>
References: <20031008172451.GA1775@born2.midworld.org>
 <3F845E0C.7020801@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <3F845E0C.7020801@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format="flowed"; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org, Rich Sahlender <rsahlen@voicenet.com>

H. Peter Anvin wrote:

>This should not be an autofs feature but an NFS feature, for obvious
>reasons: it's equally applicable for static mounts.
>
>Furhtermore, failover HAS to be done at the NFS layer.
>
>The fact that Slowlaris does it in autofs is not a good motivation --
>it's idiotic design.
>  
>

*Ahem*.  Solaris has had NFS client failover since 2.6.   Linux is still 
playing catch up in this arena.
Failover is not handled in the automount layer, but rather passed on to 
nfs layer itself.  man mount_nfs.

Mike Waychison
