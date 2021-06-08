create table member ( -- ȸ������
    id nvarchar2(20) constraint PK_MEMBER_ID PRIMARY KEY, -- �⺻Ű PK_���̺��_pk�� �÷���
    pwd nvarchar2(20) NOT NULL,
    name nvarchar2(10) NOT NULL,
    email nvarchar2(30) NOT NULL,
    address nvarchar2(50) NOT NULL,
    admin int);
select * from board where productid = 1;
select p.name, p.thumbnaillink, b.memberId, b.content, b.regtime from board b join productinfo p
on b.productid = p.productid
where b.productid in (select thumbnaillink from productinfo
                      where productid = 1);

create table productinfo ( -- ��ǰ���� ���̺�
    productId NUMBER constraint PK_PRODUCTINFO_PRODUCTID PRIMARY KEY, --pk
    productCode NUMBER NOT NULL,
    name NVARCHAR2(30) NOT NULL,
    detailedLink NVARCHAR2(100) NOT NULL,
    thumbnailLink NVARCHAR2(100) NOT NULL,
    price NUMBER NOT NULL,
    stock NUMBER
);

create table board ( -- �ı�Խ���
    memberId NVARCHAR2(20),
    productId NUMBER,
    boardID NUMBER constraint PK_BOARD_BOARDID PRIMARY KEY,
    regtime date NOT NULL,
    content NVARCHAR2(500) NOT NULL,
    -- �ܷ�Ű ����
    constraint FK_MEMBER_BOARD_MEMBERID FOREIGN KEY(memberId)
        REFERENCES MEMBER(id) ON DELETE CASCADE,
    constraint FK_PRODUCTINFO_BOARD_PRODUCTID FOREIGN KEY(productID)
        REFERENCES PRODUCTINFO(productID) ON DELETE CASCADE
);

create table basket(
    memberId NVARCHAR2(20),
    productId NUMBER,
    constraint FK_MEMBER_BASKET_MEMBERID FOREIGN KEY (memberId)
        REFERENCES MEMBER(id) ON DELETE CASCADE,
    constraint FK_PRODUCTINFO_BASKET_PRODUCTID FOREIGN KEY (productID)
        REFERENCES PRODUCTINFO(productID) ON DELETE CASCADE
);
    --�ܷ�Ű
    -- CONSTRAINT [�������� ��] FOREIGN KEY([�÷���])
    -- REFERENCES [������ ���̺� �̸�]([������ �÷�])
    -- [ON DELETE CASCADE | ON DELETE SET NULL]
    -- ������ �θ� ���̺� ���� �����Ǹ� �ڽ� ���̺��� �÷� ����, �������� �θ� ���̺� ���� �����Ǹ� �ڽ� NULL������ ����

create sequence board_seq_auto start with 1 increment by 1 minvalue 1 maxvalue 99999999;
-- ������ �ʱ�ȭ�ϰ� ���� ��
alter sequence board_seq_auto increment by 1;
-- (drop���� ����)
drop SEQUENCE board_seq_auto;
-- insert into board values(memberId, productId, board_seq_auto.nextval, title, regtime, content);
-- boardId �κп� �������� �־���
    -- CREATE SEQUENCE �������̸� START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999;
    -- start with : ���� �� ����
    -- increment by ������ �� ����
    -- maxvalue : �ִ� �� ����
    -- minvalue : �ּ� �� ����

-- auto Increment ��ȸ
select LAST_NUMBER from USER_SEQUENCES where SEQUENCE_NAME = 'board_seq_auto';
alter sequence board_seq_auto 
alter sequence board_seq_auto increment by 1;

create table basket ( -- ��ٱ��� ���� ����
    
);
    -- DetailReview
    select * from (select rownum num, L.* from (select B.memberId, B.regtime, B.content, P.name, P.thumbnaillink from board B join productinfo P on B.productId = P.productId order by regtime desc) L) where num between 1 and 9;
    
    select B.boardId, B.memberId, B.regtime, B.content, P.info, P.detailedlink
    from board B join productinfo P
    on B.productId = P.productId
    order by regtime desc;
    
drop table member; -- MEMBER table ����
drop table productinfo; -- productinfo table ����
drop table board; -- �ı�Խ��� table ����

-- BOARD ���̺� Test��    
select to_char(regtime, 'yy/mm/dd hh24:mi') from board;
insert into board values ('as', 1, board_seq_auto.nextval, 'title', sysdate, 'content');

select count(MemberId) from board
where ProductId = 1;