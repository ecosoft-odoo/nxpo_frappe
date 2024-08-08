# วิธีการติดตั้ง
1. ดาวน์โหลด source code ใส่ไว้ใน folder ที่ต้องการเช่น folder workspaces
   > git clone https://github.com/ecosoft-odoo/nxpo_frappe.git -b main
2. เข้าไปใน folder nxpo_frappe
   > cd &lt;workspace directory&gt;/nxpo_frappe
3. Ignore frappe_docker submodule จาก git
   > git config submodule.frappe_docker.ignore all
4. ดาวน์โหลด code จาก frappe_docker repository
   > git submodule init && git submodule update --remote
