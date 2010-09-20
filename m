From: Ian Kent <raven@themaw.net>
Subject: Re: -Dvariable=value not working?
Date: Mon, 20 Sep 2010 09:46:18 +0800
Message-ID: <1284947178.3095.8.camel@localhost>
References: <4C502068.1070104@nerc.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=Gp82hZoYcopKYsI/KRMOz3BxS68=;
	b=afPwFwKnH307bklpNPDeDByZNcmH0lxbJN5SqGDhAEAxf37hA6B+xtU+LWCSdb5UdPBX95+iYFVW/s/x7qZB0gLgGZeI0nzppqL/pxX49J9NOMYSYYVLrbz50BuTtdtVvFghBuRFCO7ADYvGe+tCfxlU8CjCICVr8zWMPrvlyqA=
In-Reply-To: <4C502068.1070104@nerc.ac.uk>
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
To: R.Gillman@nerc.ac.uk
Cc: autofs@linux.kernel.org

On Wed, 2010-07-28 at 13:19 +0100, Richard Gillman wrote:
> I've got a Suse SLES 11 system running automount 5.0.3 which stubbornly 
> refuses to variable substitution.
> 
> friesian:/etc/sysconfig # automount -V
> 
> Linux automount version 5.0.3
> 
> Directories:
> 
> config dir: /etc/sysconfig
> 
> maps dir: /etc
> 
> modules dir: /usr/lib64/autofs
> 
> Compile options:
> 
> DISABLE_MOUNT_LOCKING ENABLE_FORCED_SHUTDOWN ENABLE_IGNORE_BUSY_MOUNTS
> 
> WITH_LDAP WITH_SASL LIBXML2_WORKAROUND
> 
> 
> I've got LOCAL_OPTIONS="-DNERCARCH=linux" in /etc/sysconfig/autofs (I've 
> also tried "-D  NERCARCH=linux", "-D NERCARCH='linux'").

Does the init script in SLES 11 actually use LOCAL_OPTIONS?
That changed in version 5, you should have a look at the autofs
configuration file (wherever that is in SLES 11) and the init script.
You might need to use OPTIONS in configuration.

Ian
