From: Stef Bon <stef@bononline.nl>
Subject: More directories?
Date: Sun, 09 Mar 2008 21:11:10 +0100
Message-ID: <47D4445E.10100@bononline.nl>
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

some time now I've been experimenting with mounting smb shares. Now the 
script
auto.smb which comes with the autofs package, generates given a server, 
all the shares.

../server/share/<mounted samba share>

Thus, it creates one level deep paths. I'm wondering, is it possible to 
create two or even more
level deep directories with a script simular to auto.smb??

I haven't been experimenting with it.

Stef Bon
