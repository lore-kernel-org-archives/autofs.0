From: chris barry <Christopher.Barry@qlogic.com>
Subject: sudo and autofs
Date: Sat, 23 Feb 2008 23:53:17 -0500
Message-ID: <1203828797.5413.355.camel@localhost>
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

Hey everyone. This is a little off topic, but I figured some here have
solved this already.

lab machine automounts users home from production environment.
user needs to use sudo to install a file on the local lab box that is in
his automounted home. 
result: permission denied. 

Makes sense, as root_squash is the default mount option. 

The question is, is there any way to make this work while preventing a
user from accessing another user's home? Some slick program type
automount map or something? anything...?


Thanks,
-C
