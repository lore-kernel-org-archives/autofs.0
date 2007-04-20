From: Ian Kent <raven@themaw.net>
Subject: Re: Mounting a usb flash drive on /mnt
Date: Fri, 20 Apr 2007 12:58:19 +0800
Message-ID: <1177045099.3934.56.camel@raven.themaw.net>
References: <20070419181221.73C51160C1@l0ca1h0st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070419181221.73C51160C1@l0ca1h0st.com>
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
To: Derek Reid <autofs-ml@l0ca1h0st.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-04-19 at 12:12 -0600, Derek Reid wrote:
> Hi,
> 
> I'd like to mount my usb flash drive exclusively on /mnt but I'm not
> sure if this is possible.
> 
> >From the docs, it looks like /etc/auto.master has to have /mnt listed as
> the key but in the usb autofs config, but I don't know what would need
> to be listed.  I've tried "/" and "." but neither seem to take.  I get
> the following message written to the syslog:
> 
> automount[21234]: bad map format: found indirect, expected direct
> exiting
> 
> Does anyone know if this *is* possible and if so, what do I need to put
> as the key?

No idea what you mean.
What version of autofs?
How about an example of what you're attempting to do with a description
of what you've done and what you've put in what files.

Ian
