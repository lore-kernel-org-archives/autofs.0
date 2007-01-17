From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: [ANNOUNCE] autofs 5.0.1 rc3 release candidate
Date: Wed, 17 Jan 2007 11:59:49 +0100
Message-ID: <45AE01A5.9010408@inria.fr>
References: <200701041309.l04D9S9i031351@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200701041309.l04D9S9i031351@raven.themaw.net>
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
To: autofs@linux.kernel.org

Also sprach Ian Kent:
> - fix get_query_dn not looking in subtree for LDAP search (missed second
>   occurance).
Well, this patch was mine :)

Actually, I don't really care about getting mentionned in the changelog,
but I'd like my other patches from
http://svn.mandriva.com/cgi-bin/viewvc.cgi/packages/cooker/autofs/releases/5.0.1/0.rc3.1mdv2007.1/SOURCES/
to get in also, especially when they fix objectives troubles:
- autofs-5.0.1-rc1-fix-hesiod-check.patch is needed to build without
hesiod but with other libraries (such as LDAP)
- autofs-5.0.1-rc1-fix-man-page.patch fix an error in a man page, and
avoid a useless substitution

The following are more discussable, and only concern enhancing
configuration readability:
- autofs-5.0.1-rc1-drop-default-prefix-from-config.patch drop useless
DEFAULT_ prefix from configuration directives
- autofs-5.0.1-rc3-separate-config-files.patch split configuration in
two parts, one for the automount daemon, one for the automount init script
- autofs-5.0.1-rc1-cleanup-config-files-names.patch just tidify
configuration files names

Thanks.
