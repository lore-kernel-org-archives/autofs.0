From: Dylan <autofs@dylan.me.uk>
Subject: Installing autofs4.1
Date: Sat, 17 Jan 2004 23:31:52 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401172331.52858.autofs@dylan.me.uk>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello All,

After reading the posts on this list, I have d/loaded the autofs4.1 
files from ftp.kernel.org/pub/linux/daemons/autofs/v4 (all of them, 
even though I figure I don't need them all...)

My queries are:

A:
What is the difference between autofs4-4.1.0-1.src.rpm and 
autofs4-4.1.0-2.src.rpm? I notice -2- contains 
autofs-4.1.0-lookup.patch which -1- does not - is this additional, or 
already integrated in -1-. Also, -2- depends on hesiod-devel and 
openldap-devel which -1- does not. Is this related to the patch?

B:
I have no need for ldap functionality. I tried compiling from the tar 
with --without-ldap and --with-ldap=no as options to configure but the 
make still abends complaining about no ldap headers. Can I eliminate 
the ldap requirements, and if so how?

TIA
Dylan

-- 
Sweet moderation
Heart of this nation
Desert us not
We are between the wars
- Billy Bragg
