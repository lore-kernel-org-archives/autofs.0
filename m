From: Ian Kent <ikent@redhat.com>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
 servers
Date: Thu, 06 Jan 2011 15:09:24 +0800
Message-ID: <1294297764.3010.8.camel@perseus>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>
	<4D21A19D.3050303@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D21A19D.3050303@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Mon, 2011-01-03 at 11:14 +0100, Ondrej Valousek wrote:
> On 28.12.2010 03:24, Ian Kent wrote: 
> > That's right.
> > I'm supposed to break that list into individual server entries and
> > attempt a connection to each in turn.
> > 
> > Can you get a debug log for me please.
> 
> Please find the debug log attached.
> I believe it has primarily nothing to do with DNS SRV support - the
> problem in general is that autofs man page claims that you can do
> something like this:
> 
> LDAP_URI="ldap://server1 ldap://server2"

You are supposed to be able to do this.

> 
> but in fact this does not work (at least the source code does not look
> like supporting it). So in general you have 2 options how to resolve
> this:
> 
> 1) fix the autofs man page and say that the construction above is not
> possible. DNS SRV lookups must be fixed separately then.
> 2) fix the automounter so that the construction above works as
> described in the 'man auto.master' - DNS SRV lookups will then start
> working automatically, too.

I'd prefer to fix it so I'll start by checking automount.

> 
> Here is the debug log:
> 
> Dec 27 12:44:46 dorado_v1 automount[2712]: Starting automounter
> version 5.0.1-0.rc2.143.el5_5.6, master map auto.master.ldap
> Dec 27 12:44:46 dorado_v1 automount[2712]: using kernel protocol
> version 5.01
> Dec 27 12:44:46 dorado_v1 automount[2712]: lookup_nss_read_master:
> reading master files auto.master.ldap
> Dec 27 12:44:46 dorado_v1 automount[2712]: lookup(file): file
> map /etc/auto.master.ldap missing or not readable
> Dec 27 12:44:46 dorado_v1 automount[2712]: lookup_nss_read_master:
> reading master ldap auto.master.ldap
> Dec 27 12:44:46 dorado_v1 automount[2712]: parse_server_string:
> lookup(ldap): Attempting to parse LDAP information from string
> "auto.master.ldap".
> Dec 27 12:44:46 dorado_v1 automount[2712]: parse_server_string:
> lookup(ldap): mapname auto.master.ldap
> Dec 27 12:44:46 dorado_v1 automount[2712]: parse_ldap_config:
> lookup(ldap): ldap authentication configured with the following
> options:
> Dec 27 12:44:46 dorado_v1 automount[2712]: parse_ldap_config:
> lookup(ldap): use_tls: 0, tls_required: 0, auth_required: 2,
> sasl_mech: GSSAPI
> Dec 27 12:44:46 dorado_v1 automount[2712]: parse_ldap_config:
> lookup(ldap): user: (null), secret: unspecified, client principal:
> DORADO_V1$@DUBLIN.AD.S3GROUP.COM credential cache: (null)
> Dec 27 12:44:46 dorado_v1 automount[2712]: parse_init: parse(sun):
> init gathered global options: (null)
> Dec 27 12:44:46 dorado_v1 automount[2712]: get_dc_list: doing lookup
> of SRV RRs for domain dublin.ad.s3group.com
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_lookup_srv: 10 records
> returned in the answer section.
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dccorka.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dclisaa.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dcdub1.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dcduba.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dcdubb.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dcpra1.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dcsjc1.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dcsjca.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dcwro1.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: dns_parse_rr_srv: Parsed
> dccork1.dublin.ad.s3group.com [0, 100, 389]
> Dec 27 12:44:46 dorado_v1 automount[2712]: find_server: trying server
> uri ldap://dccorka.dublin.ad.s3group.com:389
> ldap://dclisaa.dublin.ad.s3group.com:389
> ldap://dcdub1.dublin.ad.s3group.com:389
> ldap://dcduba.dublin.ad.s3group.com:389
> ldap://dcdubb.dublin.ad.s3group.com:389
> ldap://dcpra1.dublin.ad.s3group.com:389
> ldap://dcsjc1.dublin.ad.s3group.com:389
> ldap://dcsjca.dublin.ad.s3group.com:389
> ldap://dcwro1.dublin.ad.s3group.com:389
> ldap://dccork1.dublin.ad.s3group.com:389
> Dec 27 12:44:46 dorado_v1 automount[2712]: do_bind: lookup(ldap):
> auth_required: 2, sasl_mech GSSAPI
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_do_kinit: initializing
> kerberos ticket: client principal DORADO_V1$@DUBLIN.AD.S3GROUP.COM
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_do_kinit: calling
> krb5_parse_name on client principal DORADO_V1$@DUBLIN.AD.S3GROUP.COM
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_do_kinit: Using tgs
> name krbtgt/DUBLIN.AD.S3GROUP.COM@DUBLIN.AD.S3GROUP.COM
> Dec 27 12:44:46 dorado_v1 pcscd: winscard.c:304:SCardConnect() Reader
> E-Gate 0 0 Not Found
> Dec 27 12:44:46 dorado_v1 last message repeated 3 times
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_do_kinit: Kerberos
> authentication was successful!
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_bind_mech: Attempting
> sasl bind with mechanism GSSAPI
> Dec 27 12:44:46 dorado_v1 automount[2712]: getuser_func: called with
> context (nil), id 16385.
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_log_func:100: GSSAPI
> Error: Unspecified GSS failure.  Minor code may provide more
> information (Unknown code krb5 7)
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_client_start failed
> for dccorka.dublin.ad.s3group.com
> Dec 27 12:44:46 dorado_v1 automount[2712]: sasl_bind_mech:
> sasl_client_start: SASL(-1): generic failure: GSSAPI Error:
> Unspecified GSS failure.  Minor code may provide more information
> (Unknown code krb5 7)
> Dec 27 12:44:46 dorado_v1 automount[2712]: do_bind: lookup(ldap):
> autofs_sasl_bind returned -1
> Dec 27 12:44:46 dorado_v1 automount[2712]: lookup(ldap): couldn't
> connect to server ldap://dccorka.dublin.ad.s3group.com:389
> ldap://dclisaa.dublin.ad.s3group.com:389
> ldap://dcdub1.dublin.ad.s3group.com:389
> ldap://dcduba.dublin.ad.s3group.com:389
> ldap://dcdubb.dublin.ad.s3group.com:389
> ldap://dcpra1.dublin.ad.s3group.com:389
> ldap://dcsjc1.dublin.ad.s3group.com:389
> ldap://dcsjca.dublin.ad.s3group.com:389
> ldap://dcwro1.dublin.ad.s3group.com:389
> ldap://dccork1.dublin.ad.s3group.com:389
> Dec 27 12:44:46 dorado_v1 automount[2712]: do_reconnect: lookup(ldap):
> failed to find available server
> 
> 
> 
> ______________________________________________________________________
> The information contained in this e-mail and in any attachments is
> confidential and is designated solely for the attention of the
> intended recipient(s). If you are not an intended recipient, you must
> not use, disclose, copy, distribute or retain this e-mail or any part
> thereof. If you have received this e-mail in error, please notify the
> sender by return e-mail and delete all copies of this e-mail from your
> computer system(s). Please direct any additional queries to:
> communications@s3group.com. Thank You. Silicon and Software Systems
> Limited. Registered in Ireland no. 378073. Registered Office: Whelan
> House, South County Business Park, Leopardstown, Dublin 18 
> 
> ______________________________________________________________________
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
