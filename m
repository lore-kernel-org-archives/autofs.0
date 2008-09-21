From: Mikel Jimenez <mikel@irontec.com>
Subject: autofs+LDAP
Date: Sun, 21 Sep 2008 23:40:07 +0200
Message-ID: <48D6BF37.1050404@irontec.com>
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

Hello Guys

I have a OpenLDAP server with user accounts. Actually, i autheticate my 
LAN machines to LDAP server and ALL OK.

I want that:

EXAMPLE:
day 1:
user1 login in machine1 and I want to mount via NFS, the home of this 
user, that is in another storage server

day 2: user 1 login in machine6 and I want to mount via NFS, the home of 
this user, that is in another storage server


I want to have all users homes, in a centralized storage server, and 
give the posibility to users to login in any machine of the LAN, and 
have they home directory mounted automaticaly.

Is that posible with autofs+LDAP?

THANKS
