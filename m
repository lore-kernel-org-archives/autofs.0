From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs problem (migration from sun to linux )
Date: Sun, 14 Mar 2004 20:32:51 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403142028380.4669@raven.themaw.net>
References: <20040314121911.D66BE23979@ws5-3.us4.outblaze.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040314121911.D66BE23979@ws5-3.us4.outblaze.com>
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
To: surya <surya_prabhakar@linuxmail.org>
Cc: autofs@linux.kernel.org

On Sun, 14 Mar 2004, surya  wrote:

> Dear Ian ,
>      Thank you for your help . But unfortunately it did not solve my problem . I run autofs modular . So I removed existing one and compiled the autofs4 tar file and also compiled the patch module(autofs4-2.4-module-20031201.tar.bz2 ) . It got installed , I restarted autofs but no luck . Most of my maps comes from NIS . still I cant see any directories . Kindly tell me is there something else which I need to check .

Did you read the documentation in the tarball?

I guess you untared it edited the macros in Makefile.conf to point to the 
source tree of the running kernel then:

make
make install

That's all you should need to do for the kernel module.

You also need to add an option to the master map like

/home	/etc/auto.home --ghost

Ian
