From: Ondrej Valousek <webserv@s3group.cz>
Subject: autofs & system libnss* libraries
Date: Wed, 24 Sep 2008 11:57:29 +0200
Message-ID: <48DA0F09.9090602@s3group.cz>
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

Hi List,

I have a question - is there any plan for autofs to use the system
libnss* libraries instead of implementing their own?
For example: If I wanted to use LDAP server to hold user accounts &
autofs maps, I would have 2 config files to configure:
- /etc/ldap.conf for libnss_ldap library
- /etc/autofs_ldap_auth.conf for automounter
It is quite confusing and it will be much more elegant to have just a
single configuration file for both services.
Is there any plan to do this in the future?

Many thanks,
Ondrej
