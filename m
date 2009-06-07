From: Stef Bon <stef@bononline.nl>
Subject: ldap and reloading
Date: Sun, 07 Jun 2009 10:38:19 +0200
Message-ID: <4A2B7C7B.7060909@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Hello,

when using static file maps, or even executable maps, when the map 
changes, you'll have to reload the daemon to make these changes effective.

How does this work when all the data is in ldap? Does the automounter 
still creates a sort of snapshot of the map in memory, and to reread the 
data provided by ldap, a reload is neccesary? ldap is well know for that 
this is not needed. For example with postfix, it can use static maps, 
and when something changes, it has te be restarted. But when the lookup 
data (for local users for example) is in ldap, this is not neccesary.

If this is the case, I go directly over to ldap.

Stef
