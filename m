From: Ian Kent <raven@themaw.net>
Subject: Re: Err:multiple hostnames not supported(migration from solaris   
 toLinux)
Date: Tue, 23 Mar 2004 09:03:58 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403230900490.25584@wombat.indigo.net.au>
References: <20040322154222.5E60921B32F@ws5-6.us4.outblaze.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040322154222.5E60921B32F@ws5-6.us4.outblaze.com>
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

On Mon, 22 Mar 2004, surya  wrote:

> hi ,
>    I am using 3.1.7 on some machines and some have 4.1.0 . It is coming on the latest version also .
> 

I also should have asked what is the form of your entry?

Although it's not he place for it, multiple weighted host names in mount 
entries has been added to 4.1.1, thanks to a patch from Michael Blandford. 

Ian
