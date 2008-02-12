From: Ian Kent <raven@themaw.net>
Subject: Re: Mount very when reboot
Date: Tue, 12 Feb 2008 15:31:45 +0900
Message-ID: <1202797905.3233.57.camel@raven.themaw.net>
References: <3a98c5000802080122q56d81c92x67806c7d15aeb108@mail.gmail.com>
	<1202717516.24318.8.camel@raven.themaw.net>
	<3a98c5000802110737y52bce2f0s2e0d3a07b9a1cf1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3a98c5000802110737y52bce2f0s2e0d3a07b9a1cf1e@mail.gmail.com>
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
To: Vincent LEFORT <vincent.lefort@gmail.com>
Cc: autofs@linux.kernel.org


On Mon, 2008-02-11 at 16:37 +0100, Vincent LEFORT wrote:
> So 
> 
> rpm -q autofs : autofs-4.1.4-6
> uname -r : 2.6.13-15.18-smp
> 
> auto.master on clients : 
>      /serveurpst /etc/auto.pst --timeout 60
> 
> auto.pst on clients :
>     prods1  -soft,intr,rsize=8192,wsize=8192,timeo=15,rw
> 192.168.0.48:/media/disk1_prods1
> 

snip ...

> 
> I will do the debug output, do you see some problems here ?

This all looks OK.
Have you checked the order of the startup on you're distribution?
If the network isn't up before autofs starts that will be a problem.

Ian
