From: "surya " <surya_prabhakar@linuxmail.org>
Subject: Re: Autofs problem (migration from sun to linux )
Date: Sun, 14 Mar 2004 17:47:13 +0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040314124713.2AA8D23979@ws5-3.us4.outblaze.com>
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
      Thx for the instant reply . I have tried in the same way  you told . I am in an environment where we have both solaris and linux clients while nis master is a solaris box .Maps come from NIS .  Does this ghost option ( /home	/etc/auto.home --ghost ) given in the master server cause any trouble for the existing solaris clients . 

Any work around would be highly appreciated .

rgds
surya



----- Original Message -----
From: Ian Kent <raven@themaw.net>
Date: Sun, 14 Mar 2004 20:32:51 +0800 (WST)
To: surya <surya_prabhakar@linuxmail.org>
Subject: Re: [autofs] Autofs problem (migration from sun to linux )

> On Sun, 14 Mar 2004, surya  wrote:
> 
> > Dear Ian ,
> >      Thank you for your help . But unfortunately it did not solve my problem . I run autofs modular . So I removed existing one and compiled the autofs4 tar file and also compiled the patch module(autofs4-2.4-module-20031201.tar.bz2 ) . It got installed , I restarted autofs but no luck . Most of my maps comes from NIS . still I cant see any directories . Kindly tell me is there something else which I need to check .
> 
> Did you read the documentation in the tarball?
> 
> I guess you untared it edited the macros in Makefile.conf to point to the 
> source tree of the running kernel then:
> 
> make
> make install
> 
> That's all you should need to do for the kernel module.
> 
> You also need to add an option to the master map like
> 
> /home	/etc/auto.home --ghost
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
