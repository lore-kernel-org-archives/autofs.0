From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs cifs mounts via Kerberos
Date: Thu, 09 Dec 2010 10:17:28 +0800
Message-ID: <1291861048.2899.18.camel@perseus>
References: <7A014DE1422A694A89BA2CE1F5692DF503831CFD@niihau.lionsgate.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <7A014DE1422A694A89BA2CE1F5692DF503831CFD@niihau.lionsgate.ca>
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
To: "Carter, Joel" <JoelC@trailerwizards.com>
Cc: autofs@linux.kernel.org

On Mon, 2010-12-06 at 12:41 -0800, Carter, Joel wrote:
> Hi there.
> 
> I am putting the finishing touches on our AD/LDAP using autofs to mount
> home directories on a Red Hat 5 box. I have login authentication working
> great, using both traditional SSH authentication (Linux does
> authentication) and GSSAPI (passes Kerberos tickets directly) for
> single-sign-on. The problem is mounting the home directories. If this is
> the wrong list for this integration stuff let me know if you know of a
> better candidate.

Yeah, this is probably the wrong place for this since it may be more to
do with cifs than autofs.

I would say log a Bugzilla bug against RHEL CIFS but, strictly speaking,
you should go via GSS support, as GSS are the group that sanity check,
gather initial information, and monitor escalations for fixes that
customers need.

But logging a Bugzilla bug may get some information reasonably quickly
if you can get some attention.

> 
> Here's my configuration:
> 
> auto.master:
> /home_cifs /etc/auto.cifs --timeout=5
> 
> auto.cifs:
> *
> -fstype=cifs,sec=krb5,user=&,uid=&,gid=lgtr,file_mode=0644,dir_mode=0755
> ://smb.domain.local/userdata/&
> 
> /etc/request-key.conf:
> ...
> create  cifs.spnego * * /usr/sbin/cifs.upcall %k
> create  dns_resolver * * /usr/sbin/cifs.upcall %k
> 
> /etc/pam.d/system-auth-ac:
> #%PAM-1.0
> # This file is auto-generated.
> # User changes will be destroyed the next time authconfig is run.
> auth        required      pam_env.so
> auth        sufficient    pam_unix.so nullok try_first_pass
> auth        sufficient    pam_krb5.so
> auth        requisite     pam_succeed_if.so uid >= 500 quiet
> auth        required      pam_deny.so
> 
> account     required      pam_unix.so
> account     sufficient    pam_succeed_if.so uid < 500 quiet
> account     sufficient    pam_krb5.so
> account     required      pam_permit.so
> 
> password    requisite     pam_cracklib.so try_first_pass retry=3
> password    sufficient    pam_unix.so md5 shadow nullok try_first_pass
> use_authtok
> password    required      pam_deny.so
> 
> session     optional      pam_keyinit.so revoke
> session     required      pam_limits.so
> session     [success=1 default=ignore] pam_succeed_if.so service in
> crond quiet use_uid
> session     required      pam_unix.so
> 
> /etc/pam.d/sshd
> #%PAM-1.0
> auth       include      system-auth
> account    required     pam_nologin.so
> account    include      system-auth
> password   include      system-auth
> session    optional     pam_keyinit.so force revoke
> session    include      system-auth
> session    required     pam_loginuid.so
> 
> Every user has their unixHomeDirectory set to /home_cifs/<username>
> 
> The mount doesn't seem to work on login but autofs is working. It works
> fine once logged in (most of the time but does fail sometimes as well)
> and I change the directory to the home:
> 
> Dec  6 11:57:37 bilbo-rh5 cifs.upcall: key description:
> cifs.spnego;0;0;3f000000;ver=0x2;host=smb.domain.local;ip4=192.168.1.58;
> sec=mskrb5;uid=0x4e20;user=lguser
> Dec  6 11:57:37 bilbo-rh5 cifs.upcall: find_krb5_cc: considering
> /tmp/krb5cc_20000_BfIUPW5852
> Dec  6 11:57:37 bilbo-rh5 cifs.upcall: find_krb5_cc:
> FILE:/tmp/krb5cc_20000_BfIUPW5852 is valid ccache
> Dec  6 11:57:37 bilbo-rh5 cifs.upcall: handle_krb5_mech: getting service
> ticket for cifs/smb.domain.local
> Dec  6 11:57:37 bilbo-rh5 cifs.upcall: handle_krb5_mech: obtained
> service ticket
> Dec  6 11:57:37 bilbo-rh5 automount[5642]: mount(generic): mounted
> //smb.domain.local/userdata/lguser type cifs on /home_cifs/lguser
> Dec  6 11:57:37 bilbo-rh5 automount[5642]: mounted /home_cifs/lguser
> 
> Klist shows this:
> 12/06/10 12:06:55  12/06/10 21:17:32  cifs/smb.domain.local@DOMAIN.CA
>         renew until 12/06/10 22:06:55
> 
> Then I can login without problem until automount expires the mount. When
> it doesn't work this is what is shown:
> 
> Dec  6 11:59:09 bilbo-rh5 cifs.upcall: key description:
> cifs.spnego;0;0;3f000000;ver=0x2;host=smb.domain.local;ip4=192.168.1.58;
> sec=mskrb5;uid=0x4e20;user=lguser
> Dec  6 11:59:09 bilbo-rh5 cifs.upcall: handle_krb5_mech: getting service
> ticket for cifs/smb.domain.local
> Dec  6 11:59:09 bilbo-rh5 cifs.upcall: handle_krb5_mech: failed to
> obtain service ticket (-1765328189)
> Dec  6 11:59:09 bilbo-rh5 cifs.upcall: handle_krb5_mech: getting service
> ticket for host/smb.domain.local
> Dec  6 11:59:09 bilbo-rh5 cifs.upcall: handle_krb5_mech: failed to
> obtain service ticket (-1765328189)
> Dec  6 11:59:09 bilbo-rh5 kernel:  CIFS VFS: cifs_mount failed w/return
> code = -126
> Dec  6 11:59:09 bilbo-rh5 automount[5642]: >> Refer to the mount.cifs(8)
> manual page (e.g. man mount.cifs)
> Dec  6 11:59:09 bilbo-rh5 automount[5642]: mount(generic): failed to
> mount //smb.domain.local/userdata/lguser (type cifs) on
> /home_cifs/lguser
> Dec  6 11:59:09 bilbo-rh5 automount[5642]: failed to mount
> /home_cifs/lguser
> 
> I have wireshark traces as well for success and non-success.
> 
> Any help is much appreciated, I'm almost there!
> 
> Joel.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
