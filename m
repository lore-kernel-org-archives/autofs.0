From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs problem (migration from sun to linux )
Date: Sun, 14 Mar 2004 22:02:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403142201320.6046@raven.themaw.net>
References: <20040314124713.2AA8D23979@ws5-3.us4.outblaze.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040314124713.2AA8D23979@ws5-3.us4.outblaze.com>
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
>       Thx for the instant reply . I have tried in the same way  you told . I am in an environment where we have both solaris and linux clients while nis master is a solaris box .Maps come from NIS .  Does this ghost option ( /home	/etc/auto.home --ghost ) given in the master server cause any trouble for the existing solaris clients . 

Yes.

Create a file master map localy to refer to the NIS maps.

Ian
