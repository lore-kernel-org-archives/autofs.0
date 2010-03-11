From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs LDAP mount question
Date: Thu, 11 Mar 2010 14:28:01 +0800
Message-ID: <1268288881.2247.17.camel@localhost>
References: <dc3ecf561003102100h572cb015l5654ca179028795e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=pPe1VeXOiA/BFfGhMQPzd3Ia8mI=;
	b=QnO1TFqV4JoahcmYK9T7SUO7Hr6wssvUw68/pdRNSyI1liaiOFtptpwmRvUQ0/Di8DFq2RYGlB6UONtS1M7QhsZio/sTUdYbRl7Q0Vt+qGWUIjnnIYMA5GoRhvwY80Khkhjoiny9JvyrKpGNezEV5fcuOf0/H9ma7hNaETryFzs=
In-Reply-To: <dc3ecf561003102100h572cb015l5654ca179028795e@mail.gmail.com>
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
To: Techie <techchavez@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2010-03-10 at 22:00 -0700, Techie wrote:
> Hello,
> 
> I have a simple question regarding LDAP direct map mounts.
> 
> If I use a local direct map "/etc/direct_map"  with the below contents
> to map NFS directories on two different file systems.
> 
> /data                                    red:/usr/local/app   \
>          /libs/apps                    red:/var/libs/apps
> 
> Both mount points to map properly. The /data directory shows the
> correct contents of red:/usr/local/app. And the /data/lib/apps
> directory also shows the correct contents of  red:/var/libs/apps. This
> is what I believe are nested mount points. However when I try the same
> thing with an LDAP direct map it fails. he contents of the same map in
> LDAP is below.
> 
> dn: automountKey=/data,automountMapName=direct_map,ou=Autofs,dc=example,dc=com
> automountInformation: -fstype=nfs,rw red:/usr/local/app
> automountKey: /data
> objectClass: automount
> objectClass: top
> 
> dn: automountKey=/data/libs/apps,automountMapName=direct_map,ou=Autofs,dc=example,dc=com
> automountKey: /data/libs/apps
> objectClass: automount
> objectClass: top
> automountInformation: -fstype=nfs,rw red://var/libs/apps
> 
> 
> When I do this in my LDAP map as shown above, the mount points do not
> show up correctly. The /data directory covers up one of the 2 mount
> points. So it looks like nested mount points don't work in LDAP or I
> am not using correct syntax. All my other LDAP mounts work but two
> mount points in the same dir does not work like it does with local
> direct maps.
> 
> Can you please confirm or deny if I can achieve nested mount points
> using LDAP direct maps like I can with local direct maps as shown
> above?

LDAP map isn't quite right.

The LDAP map entry must be the same as your file map.

In your file map the direct mount is
key = "/data"
location = "/ red:/usr/local/app /libs/apps red:/var/libs/apps"

In your original file map the "/" offset has been implied because the
syntax allows it to be optional.

and in LDAP
key = "/data"
location = "red:/usr/local/app"

key = "/data/libs/apps"
Invalid, you can't nest distinct direct mounts.

You need to use the same value for location as you did for the file map
in LDAP.

> 
> 
> Thank you
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
