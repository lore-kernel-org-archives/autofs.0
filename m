From: Ian Kent <raven@themaw.net>
Subject: Re: Map errors
Date: Thu, 01 May 2008 23:07:10 +0800
Message-ID: <1209654430.19249.16.camel@raven.themaw.net>
References: <07A371D457B501478C1DB3C3DE8372D7017C265B@GSBHEX2V.gsb.uchicago.edu>
	<x49fxt3che8.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49fxt3che8.fsf@segfault.boston.devel.redhat.com>
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
To: "Young, Darren" <Darren.Young@chicagogsb.edu>
Cc: autofs@linux.kernel.org


On Wed, 2008-04-30 at 14:43 -0400, Jeff Moyer wrote:
> "Young, Darren" <Darren.Young@chicagogsb.edu> writes:
> 
> > Ok, so I set /etc/sysconfig/autofs to what looks to be the format Sun
> > wants:
> >
> >  
> >
> > DEFAULT_MAP_OBJECT_CLASS="automountMap"
> > DEFAULT_ENTRY_OBJECT_CLASS="automount"
> > DEFAULT_MAP_ATTRIBUTE="automountMapName"
> > DEFAULT_ENTRY_ATTRIBUTE="automountKey"
> > DEFAULT_VALUE_ATTRIBUTE="automountInformation"
> 
> Good so far.
> 
> > And I set the following there:
> > DEFAULT_MASTER_MAP_NAME="ldap:automountMapName=auto_home"

Judging by the error messages you're seeing I'll bet this is actually an
indirect map that is normally referred to by the master map.

The master map has quite a different format to the maps themselves.
See auto.master(5) and autofs(5).

Ian
