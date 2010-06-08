From: Matthias =?iso-8859-1?Q?K=F6nig?= <mk@phasorlab.de>
Subject: Re: Loopback mounting seems to fail
Date: Tue, 8 Jun 2010 16:45:13 +0200
Message-ID: <20100608144513.GA6789@phasorlab.de>
References: <alpine.LSU.2.01.1006081456230.26148@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.01.1006081456230.26148@obet.zrqbmnf.qr>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: autofs@linux.kernel.org

Hi Jan,

Jan Engelhardt <jengelh@medozas.de> wrote:
> I have here an openSUSE 11.2 with 2.6.33.5 and autofs-5.0.4-6.2.1.x86_64
> 
> /etc/auto.master:
> +auto.master
> /-	auto.direct
> 
> /etc/auto.direct:
> /data/repository/sles11/x64/dvd1	-fstype=iso9660,loop,ro	/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
> <and other mounts>
> 
Did you try (note the colon before the path to the file to be loop mounted)?

/etc/auto.master:
/data/repository/sles11/x64/dvd1	-fstype=iso9660,loop,ro	:/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso

Matthias
