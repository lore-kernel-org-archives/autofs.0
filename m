From: Ian Kent <raven@themaw.net>
Subject: Re: "syntax error in nsswitch config near [ syntax error
	]" ?
Date: Wed, 26 Sep 2007 23:17:13 +0800
Message-ID: <1190819833.12109.13.camel@raven.themaw.net>
References: <200709261112.35225.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261112.35225.vda.linux@googlemail.com>
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
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-09-26 at 11:12 +0100, Denys Vlasenko wrote:
> Hi Ian,
> 
> I tried to start automount with command line like this one:
> 
> automount -f -s -v --timeout 15 master.file
> 
> and it says:
> 
> 
> Starting automounter version 5.0.0_beta1, master map master.file
> syntax error in nsswitch config near [ syntax error ]
> 
> lookup_nss_read_master: can't to read name service switch config.
> master_read_master: can't read master map master.file
> 
> 
> Well, my mistake was that I should use fully-qualified filename ($PWD/master.file),
> but error message is misleading. It says that my /etc/nsswitch.conf
> is bad (well, it doesn't even mention "/etc/nsswitch.conf", I need to
> infer that!).
> 
> But my /etc/nsswitch.conf has no syntax errors:
> 
> passwd:         compat
> group:          compat
> shadow:         compat
> hosts:          files dns [!UNAVAIL=return]
> networks:       files
> ethers:         files
> protocols:      files
> rpc:            files
> services:       files
> 
> it just doesn't have automounter maps. This is not a crime.
> 
> Message is also complains about /etc/nsswitch.conf FIRST,
> and THEN complains "can't read master map master.file",
> but actual order of these events is different - if master
> file is found, /etc/nsswitch.conf is not consulted.
> 
> Can this be improved?

Does this help?
http://git.kernel.org/?p=linux/storage/autofs/autofs.git;a=commitdiff;h=b8e06337764df00b30901c7787e0d1861c2f9901

Patch is also on kernel.org as autofs-5.0.2-default-nsswitch.patch.
Beware that there are quite a few patches that can depend on one another
but if you choose to selectively apply them you can obviously ignore the
CHANGELOG rejects.
