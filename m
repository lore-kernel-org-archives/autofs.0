From: Stef Bon <stef@bononline.nl>
Subject: Add mountpoints to mastermap dynamically.
Date: Mon, 28 Apr 2008 16:17:05 +0200
Message-ID: <4815DC61.1080501@bononline.nl>
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

again a question.

The construction I'm working on does add a mountpoint dynamically to an 
existing map.
After added (first some checking the mountpoint is not already included) 
a reload is
done with the running automount (HUP signal). The same after removing a 
mountpoint.

It works very good, but I'm wondering, is this the way to do this??
Isn't there a autofsctl program???

Stef Bon
