From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Map errors
Date: Wed, 30 Apr 2008 14:43:59 -0400
Message-ID: <x49fxt3che8.fsf@segfault.boston.devel.redhat.com>
References: <07A371D457B501478C1DB3C3DE8372D7017C265B@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D7017C265B@GSBHEX2V.gsb.uchicago.edu>
	(Darren Young's message of "Mon, 28 Apr 2008 16:23:07 -0500")
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

"Young, Darren" <Darren.Young@chicagogsb.edu> writes:

> Ok, so I set /etc/sysconfig/autofs to what looks to be the format Sun
> wants:
>
>  
>
> DEFAULT_MAP_OBJECT_CLASS="automountMap"
> DEFAULT_ENTRY_OBJECT_CLASS="automount"
> DEFAULT_MAP_ATTRIBUTE="automountMapName"
> DEFAULT_ENTRY_ATTRIBUTE="automountKey"
> DEFAULT_VALUE_ATTRIBUTE="automountInformation"

Good so far.

> And I set the following there:
> DEFAULT_MASTER_MAP_NAME="ldap:automountMapName=auto_home"

You should only need:
DEFAULT_MASTER_MAP_NAME="auto_master"

> And all auto.master has is this:

> /home  ldap

Not quite right.  Given what I think you're trying to do, you don't want
a file called /etc/auto.master at all.

> As autofs starts up I receive the following in syslog:
>
> Apr 28 12:10:03 gsbtestfilervm automount[22969]: Starting automounter
> version 5.0.1-0.rc2.55, master map ldap:automountMapName=auto_home
>
> Apr 28 12:10:03 gsbtestfilervm automount[22969]: using kernel protocol
> version 5.00
>
> Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
> error in map near [ /mbahome/& ]

I believe these are all syntax errors in your master map.  Can you give
us the contents of that?

-Jeff
