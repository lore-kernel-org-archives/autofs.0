From: Ian Kent <raven@themaw.net>
Subject: Re: automounting replicated servers using NFSv4 fails
Date: Mon, 21 Feb 2011 20:38:11 +0800
Message-ID: <1298291891.13008.2.camel@perseus>
References: <1298034589.18517.52.camel@puppy.sonytel.be>
	<1298087286.2851.29.camel@perseus>
	<1298280412.2072.0.camel@puppy.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=l5QafYR3JJBBjZrBb48tSEyeZlo=;
	b=EjX965DsVE+fVQYQaimebTiZwR8NyyOf4YYIcWnS3Qoaj38N7oCZnEAXoC/HNi7yV6bbYztsDQn27zU+21Qu8onTu97317Lj+OJMsUejLFlCh512ZqrUlCEZvNLxMNQwelQxvJ9DFPEZeyE5W+REWosVyB9ywqLvahuyA3Q6XUE=
In-Reply-To: <1298280412.2072.0.camel@puppy.sonytel.be>
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
To: Nico De Ranter <nico.deranter@sonycom.com>
Cc: autofs@linux.kernel.org

On Mon, 2011-02-21 at 10:26 +0100, Nico De Ranter wrote:
> On Sat, 2011-02-19 at 11:48 +0800, Ian Kent wrote:
> > On Fri, 2011-02-18 at 14:09 +0100, Nico De Ranter wrote:
> > > Hi,
> > > 
> > > I have a number of Linux clients (Ubuntu 10.04) that mount a (read-only)
> > > directory from 3 replicated servers using NFSv3.  I am now in the
> > > process of moving to NFSv4.  I can mount the directories using NFSv4
> > > manually. I can mount the directories using autofs over NFSv4 when I
> > > specify only 1 server (any of the 3 will work), but when I add all 3
> > > servers to the automount configuration file the mount fails.
> > 
> > Works OK for me, on Fedora 12.

Like I said, that's F14.

> 
> Which version of autofs are you using?

Fedora 14 has 5.0.5 with, essentially all upstream patches except:

autofs-5.0.4-always-read-file-maps-mount-lookup-map-read-fix.patch
autofs-5.0.5-fix-direct-map-not-updating-on-reread.patch
autofs-5.0.5-add-external-bind-method.patch
autofs-5.0.5-fix-add-simple-bind-auth.patch
autofs-5.0.5-add-dump-maps-option.patch
autofs-5.0.5-fix-submount-shutdown-wait.patch

And kernel current kernel revision is 2.6.35.10-74.fc14.

Ian
