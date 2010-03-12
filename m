From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs LDAP mount question
Date: Fri, 12 Mar 2010 10:48:30 +0800
Message-ID: <1268362110.2495.7.camel@localhost>
References: <dc3ecf561003102100h572cb015l5654ca179028795e@mail.gmail.com>
	<1268288881.2247.17.camel@localhost>
	<dc3ecf561003111732l683d852cg60e5c6db379273fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=bwPrbkbl1gl0I1WAF8AaIXSP0h8=;
	b=mavMmmwSLo1DI5FCyB8WKVLgt+Bs+OjQ6QcHupaJ2wS2yLqhUMKESMLl++jRP2Xyz0XAb7Gb3FHwj8+LiTrOBgVGuebah8SVR7Fk9EffkAu/D3ZrV5TggcbtnTOvVzOh/3doPScGeg0IVVvxAgWX45RNRCJOjtvM+q7TFpcU6FY=
In-Reply-To: <dc3ecf561003111732l683d852cg60e5c6db379273fa@mail.gmail.com>
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

On Thu, 2010-03-11 at 18:32 -0700, Techie wrote:
> On Wed, Mar 10, 2010 at 11:28 PM, Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2010-03-10 at 22:00 -0700, Techie wrote:
> >> Hello,
> >>
> >> I have a simple question regarding LDAP direct map mounts.
> >>
> >> If I use a local direct map "/etc/direct_map"  with the below contents
> >> to map NFS directories on two different file systems.
> >>
> >> /data                                    red:/usr/local/app   \
> >>          /libs/apps                    red:/var/libs/apps
> >>
> >> Both mount points to map properly. The /data directory shows the
> >> correct contents of red:/usr/local/app. And the /data/lib/apps
> >> directory also shows the correct contents of  red:/var/libs/apps. This
> >> is what I believe are nested mount points. However when I try the same
> >> thing with an LDAP direct map it fails. he contents of the same map in
> >> LDAP is below.
> >>
> >> dn: automountKey=/data,automountMapName=direct_map,ou=Autofs,dc=example,dc=com
> >> automountInformation: -fstype=nfs,rw red:/usr/local/app
> >> automountKey: /data
> >> objectClass: automount
> >> objectClass: top
> >>
> >> dn: automountKey=/data/libs/apps,automountMapName=direct_map,ou=Autofs,dc=example,dc=com
> >> automountKey: /data/libs/apps
> >> objectClass: automount
> >> objectClass: top
> >> automountInformation: -fstype=nfs,rw red://var/libs/apps
> >>
> >>
> >> When I do this in my LDAP map as shown above, the mount points do not
> >> show up correctly. The /data directory covers up one of the 2 mount
> >> points. So it looks like nested mount points don't work in LDAP or I
> >> am not using correct syntax. All my other LDAP mounts work but two
> >> mount points in the same dir does not work like it does with local
> >> direct maps.
> >>
> >> Can you please confirm or deny if I can achieve nested mount points
> >> using LDAP direct maps like I can with local direct maps as shown
> >> above?
> >
> > LDAP map isn't quite right.
> >
> > The LDAP map entry must be the same as your file map.
> >
> > In your file map the direct mount is
> > key = "/data"
> > location = "/ red:/usr/local/app /libs/apps red:/var/libs/apps"
> >
> > In your original file map the "/" offset has been implied because the
> > syntax allows it to be optional.
> >
> > and in LDAP
> > key = "/data"
> > location = "red:/usr/local/app"
> >
> > key = "/data/libs/apps"
> > Invalid, you can't nest distinct direct mounts.
> >
> > You need to use the same value for location as you did for the file map
> > in LDAP.
> >
> >>
> >>
> >> Thank you
> >>
> >> _______________________________________________
> Ian,
> Thanks a bunch for pointing out that the "/" offset is syntactically
> optional for file based maps but is necessary in LDAP. That really
> helped my understanding of both formats..

No, actually it's always optional but can cause confusion when omitted.

The issue was that you can't break up the mount location into two
separate entries (either in a file map or LDAP, LDAP convention just
happens to make you want to do it that way). You just need to feed the
same string to the daemon whether the map is in a file or stored in
LDAP.

Ian
