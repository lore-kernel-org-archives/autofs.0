From: Ian Kent <raven@themaw.net>
Subject: Re: Disabling bind mounts
Date: Thu, 08 Jul 2010 10:28:57 +0800
Message-ID: <1278556137.2967.22.camel@localhost>
References: <alpine.LRH.0.9999.1007071010390.18053@firefly.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=n7yCvmeqR451qtIRFhj9pCKaO98=;
	b=FdIqiwGJdS5V7o+71dkEPKayOB8dhah5FggMXuMR0rmc5xJYb7cymznOt/VvIZCgz4d1INOhNM/D+kIx8HKzfXoE4RkqwQWKdhNAu0LWaf9LcEj6uWDcz6+ifydy4iVmvg5ZdZ8lf78/kolb+PQ9F59EX/s6w77gnto/RNsaleE=
In-Reply-To: <alpine.LRH.0.9999.1007071010390.18053@firefly.vgersoft.com>
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
To: Steve Thompson <smt@vgersoft.com>
Cc: autofs@linux.kernel.org

On Wed, 2010-07-07 at 10:11 -0400, Steve Thompson wrote:
> Is there any way to _disable_ bind mounts, always using the NFS stack? I 
> need this for a drbd+heartbeat failover scenario.

Try using pseudo mount option "nosymlink".

I know the name is sounds wrong and I probably should change it and
document it but I haven't, oops!

Also, if you specify the port=<NFS port> mount option that will prevent
bind mounting.

Ian
