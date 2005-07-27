From: David Johnson <davidj@ICSI.Berkeley.EDU>
Subject: autofs-4.1.4/samples/rc.autofs.in bad use of grep \B
Date: Wed, 27 Jul 2005 13:04:59 -0700
Message-ID: <17127.59627.203496.547988@fig.ICSI.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aV21nj69S4"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--aV21nj69S4
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

autofs-4.1.4/samples/rc.autofs.in uses \B incorrectly in grep
commands.  \B actually means "not edge of word", but the script uses
it to mean "beginning of word".  Fortunately, due to the script
writer assuming "-" is part of a word, but this not being the case
when LANG==C, it works under most common circumstances (but
breaks with e.g. --no--verbose in /etc/sysconfig/autofs).
However, it may cease to work if more command-line args get added to
automount.

I've posted a tested patch against RHEL3 in bugzilla.redhat.com for
Fedora Devel.  I've also forward-ported the patch to autofs-4.1.4 and
included it here.  Note that although this is very similar to the
RHEL3 patch and may well work, unfortunately I have no reasonable way
of testing it.

Cheers,

David.



--aV21nj69S4
Content-Type: application/octet-stream
Content-Description: rc.autofs.in patch
Content-Disposition: attachment;
	filename="rc.autofs.in.patch"
Content-Transfer-Encoding: base64

LS0tIHJjLmF1dG9mcy5pbi5zYXYJMjAwNS0wNC0xMSAwNDozMDo1NC4wMDAwMDAwMDAgLTA3MDAK
KysrIHJjLmF1dG9mcy5pbgkyMDA1LTA3LTI3IDEyOjQ4OjMzLjAwMDAwMDAwMCAtMDcwMApAQCAt
MjQ4LDExICsyNDgsMTMgQEAKIAkJIyB0aG9zZSBwYXJ0aWN1bGFyIG9wdGlvbnMgb3V0LgogCQk6
IGVjaG8gREFFTU9OT1BUSU9OUyBPUFRJT05TICRkYWVtb25vcHRpb25zICRvcHRpb25zCiAJCXN0
YXJ0dXBvcHRpb25zPQotCQlpZiBlY2hvICIkb3B0aW9ucyIgfCBncmVwIC1xRSAtLSAnXEItKHRc
YnwtdGltZW91dFxiPSknIDsKKwkJaWYgZWNobyAiICRvcHRpb25zICIgfCBcCisJCSAgICBncmVw
IC1xRSAtLSAnW1s6c3BhY2U6XV0tKHRbWzpzcGFjZTpdWzpkaWdpdDpdXXwtdGltZW91dD0pJzsK
IAkJdGhlbgogCQkgICAgc3RhcnR1cG9wdGlvbnM9Ii0tdGltZW91dD0kKGVjaG8gJG9wdGlvbnMg
fFwKIAkJCXNlZCAncy8uKi1cKHRbXjAtOV0qXHwtdGltZW91dFwpWyBcdD1dKlwoWzAtOV1bMC05
XSpcKS4qJC9cMi9nJykiCi0JCWVsaWYgZWNobyAiJGRhZW1vbm9wdGlvbnMiIHwgZ3JlcCAtcSAt
LSAnLXQnIDsKKwkJZWxpZiBlY2hvICIgJGRhZW1vbm9wdGlvbnMgIiB8IFwKKwkJICAgIGdyZXAg
LXFFIC0tICdbWzpzcGFjZTpdXS0odFtbOnNwYWNlOl1bOmRpZ2l0Ol1dfC10aW1lb3V0PSknIDsK
IAkJdGhlbgogCQkgICAgIyBJdCdzIG9rYXkgdG8gYmUgc2xvcHB5IHdpdGggREFFTU9OT1BUSU9O
UyBhcyB0aGVyZSBpcyBubwogCQkgICAgIyBwb3NzaWJpbGl0eSBvZiBjb25mbGljdGluZyB3aXRo
IG1vdW50IG9yIG1hcCBvcHRpb25zLgpAQCAtMjYxLDcgKzI2Myw4IEBACiAJCWZpCiAKIAkJIyBD
aGVjayBmb3IgdGhlIGdob3N0IG9wdGlvbgotCQlpZiBlY2hvICIkZGFlbW9ub3B0aW9ucyAkb3B0
aW9ucyIgfCBncmVwIC1xRSAtLSAnXEItKGdcYnwtZ2hvc3RcYiknIDsKKwkJaWYgZWNobyAiICRk
YWVtb25vcHRpb25zICRvcHRpb25zICIgfCBcCisJCSAgICBncmVwIC1xRSAtLSAnW1s6c3BhY2U6
XV0tKGd8LWdob3N0KVtbOnNwYWNlOl1dJyA7CiAJCXRoZW4KIAkJICAgIHN0YXJ0dXBvcHRpb25z
PSIkc3RhcnR1cG9wdGlvbnMgLS1naG9zdCIKIAkJZmkKQEAgLTI3MiwxNSArMjc1LDE1IEBACiAJ
CSAgICBzdGFydHVwb3B0aW9ucz0iJHN0YXJ0dXBvcHRpb25zIC0tZ2hvc3QiCiAJCWZpCiAJCSMg
Q2hlY2sgZm9yIHZlcmJvc2UKLQkJaWYgZWNobyAiJGRhZW1vbm9wdGlvbnMgJG9wdGlvbnMiIHwg
XAotCQkJCQlncmVwIC1xRSAtLSAnXEItKHZcYnwtdmVyYm9zZVxiKScgOworCQlpZiBlY2hvICIg
JGRhZW1vbm9wdGlvbnMgJG9wdGlvbnMgIiB8IFwKKwkJCWdyZXAgLXFFIC0tICdbWzpzcGFjZTpd
XS0odnwtdmVyYm9zZSlbWzpzcGFjZTpdXScgOwogCQl0aGVuCiAJCSAgICBzdGFydHVwb3B0aW9u
cz0iJHN0YXJ0dXBvcHRpb25zIC0tdmVyYm9zZSIKIAkJZmkKIAogCQkjIENoZWNrIGZvciBkZWJ1
ZwotCQlpZiBlY2hvICIkZGFlbW9ub3B0aW9ucyAkb3B0aW9ucyIgfCBcCi0JCQkJCWdyZXAgLXFF
IC0tICdcQi0oZFxifC1kZWJ1Z1xiKScgOworCQlpZiBlY2hvICIgJGRhZW1vbm9wdGlvbnMgJG9w
dGlvbnMgIiB8IFwKKwkJCWdyZXAgLXFFIC0tICdbWzpzcGFjZTpdXS0oZHwtZGVidWcpW1s6c3Bh
Y2U6XV0nIDsKIAkJdGhlbgogCQkgICAgc3RhcnR1cG9wdGlvbnM9IiRzdGFydHVwb3B0aW9ucyAt
LWRlYnVnIgogCQlmaQo=
--aV21nj69S4
Content-Type: text/plain; charset=us-ascii
Content-Description: .signature
Content-Transfer-Encoding: 7bit


-- 
David Johnson, davidj@ICSI.Berkeley.EDU, (510) 666-2983
System Administrator, International Computer Science Institute

--aV21nj69S4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--aV21nj69S4--

