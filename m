From: Marc Weber <marco-oweber@gmx.de>
Subject: Which version to uses, nsswitch.conf parse errors
Date: Tue, 28 Apr 2009 22:12:19 +0200
Message-ID: <20090428201219.GC6042@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hi at all,

I'd like to add some automount support to the nixos linux distribution.
however I don't know exactly which version to I should use?

automount v5 (autfs4 kernel module (?)) or automount v4?

For now I've tried v5. However when starting automount I get some parse
errors:

[...]
--accepting rule at line 92 ("
")
--accepting rule at line 92 ("
")
--accepting rule at line 87 ("automount:")
--accepting rule at line 95 (" ")
--accepting rule at line 97 ("files")
syntax error in nsswitch config near [ syntax error ]

My nsswitch.conf is attached below.


It looks to me like the lexer ignoring everything until it reaches
a ^automount line?

Should I stick to the older automount version?
Maybe you can help me understand the problem so that I can try improving
the error message?

I've built the 9a77464b git version.

Thanks
Marc Weber

My nsswitch.conf:

psswd:         ldap files
group:          ldap files
shadow:         ldap files

hosts:          files dns
networks:       files dns

services:       files
protocols:      files

automount: files nis
