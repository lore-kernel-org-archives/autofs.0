From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: Exporting UID to userspace?
Date: Sat, 5 Jun 2004 18:00:14 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3841A0@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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

Hi, autofs hackers!

Is it possible with the current autofs protocol to export UID of (mount)
requesting process to the userspace automount daemon? If not, I guess
that it is rather trivial feature enhancement request ;)
The matter of this RFE is need to mount smbfs shares on behalf of
requestng users, with their own passwords...

Thanks in advance,
Dimitry.
