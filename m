From: abo <abo@brujulatelecom.com>
Subject: can write on smb resource
Date: Wed, 12 Jan 2005 16:57:24 +0100
Message-ID: <20050112165724.45d20f9a@localhost>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

hi!

im using an ldap server to mount several smb resources. i can get it
mounted with no problems except i can't write on it even with rw option.
i think this is something regarding the fact that files are owned by
root. i know that autofs always mount things as root, so how can i avoid
this problem?

thx

abo
