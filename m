From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 16:58:53 -0400
Message-ID: <x49mynjezqq.fsf@segfault.boston.devel.redhat.com>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	<x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D70178387D@GSBHEX2V.gsb.uchicago.edu>
	<x49lk33giw0.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017838DA@GSBHEX2V.gsb.uchicago.edu>
	<x493apbghkr.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D701783912@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D701783912@GSBHEX2V.gsb.uchicago.edu>
	(Darren Young's message of "Thu, 24 Apr 2008 14:54:25 -0500")
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
To: "Young, Darren" <Darren.Young@ChicagoGSB.edu>
Cc: autofs@linux.kernel.org

"Young, Darren" <Darren.Young@ChicagoGSB.edu> writes:

> Apr 24 14:35:33 gsbtestfilervm automount[8138]: Starting automounter
> version 5.0.1-0.rc2.55, master map auto.master
>
> On:
>
> [root@gsbtestfilervm log]# cat /etc/redhat-release 
> Red Hat Enterprise Linux Server release 5.1 (Tikanga)
>
> Added daemon.* to syslog and started autofs:
>
> Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config: ldap
> authentication configured with the following options: 
> Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config:
> use_tls: 0, tls_required: 0, auth_required: 2, sasl_mech: DIGEST-MD5 
> Apr 24 14:47:16 gsbtestfilervm automount[8283]: parse_ldap_config: user:
> cn=Directory Manager, secret: specified, client principal: (null) 
> Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_bind_mech:
> Attempting sasl bind with mechanism DIGEST-MD5
> Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_log_func: No worthy
> mechs found
> Apr 24 14:47:16 gsbtestfilervm automount[8283]: sasl_bind_mech:
> sasl_client start failed with error: SASL(-4): no mechanism available:
> No worthy mechs found

Hmm.  Do you have the cyrus-sasl-md5 package installed?  rpm -q
cyrus-sasl-md5 will tell you.  If so, then can you get a packet capture
during the autofs start (and failure)?  Be sure to capture packet data
by specifying a snaplen of 0 if using tcpdump.

Thanks!
Jeff
