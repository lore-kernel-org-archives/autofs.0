From: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Subject: [PATCH] Sanity checks for brackets (escaped or otherwise)
	in server name
Date: Fri,  1 Apr 2011 14:43:03 +0530
Message-ID: <1301649183-8467-1-git-send-email-siddhesh.poyarekar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
	bh=RRBON+A7WXMLKXSdfvknDWzhn4WmXOBTuGBqAiu3+t4=;
	b=p4qP0eTwCAmyfMrgYpIaADM7lAPIG2FSCP6vGFOzocWZX7Er91ktoVJZyyUK+prhsl
	wXayRd4mnIfrU9LuhSOAoLzW4YBUpcz/n/Pjk03kPAwUc52VeWe0b+5HMCf4cyzYLGcT
	fXptNfphIp7t3ElmvBrduL66BIHjqiczPxz0I=
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
To: autofs@linux.kernel.org
Cc: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>

When autofs is configured as follows:

* -nodev,nosuid,intr,soft,retry=10,proto=tcp &:/tmp1

One could make a mount request as follows:

df /autom/tmp1/som\(efile

and crash automount, since automount tries to parse the brackets to
get the weight for the server. Automount should not parse these
brackets if they're escaped.

Also throw a syntax error in case of mismatched brackets instead of
crashing. Sample configuration for this:

* -nodev,nosuid,intr,soft,retry=10,proto=tcp foo(2:/tmp1

Signed-off-by: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
---
 modules/replicated.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/modules/replicated.c b/modules/replicated.c
index 975c254..248da54 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -1206,7 +1206,7 @@ static char *seek_delim(const char *s)
 	char *delim;
 
 	delim = strpbrk(p, "(, \t:");
-	if (delim && *delim != ':')
+	if (delim && *delim != ':' && (delim == s || *(delim - 1) != '\\'))
 		return delim;
 
 	while (*p) {
@@ -1255,6 +1255,12 @@ int parse_location(unsigned logopt, struct host **hosts,
 					*delim = '\0';
 					weight = atoi(w);
 				}
+				else {
+					/* syntax error - Mismatched brackets */
+					free_host_list(hosts);
+					free(str);
+					return 0;
+				}
 				delim++;
 			}
 
-- 
1.7.4
